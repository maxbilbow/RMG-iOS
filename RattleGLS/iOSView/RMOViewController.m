//
//  ViewController.m
//  texture-coordinates
//
//  Created by Christoph Halang on 28/02/15.
//  Copyright (c) 2015 Christoph Halang. All rights reserved.
//

#import <RattleGLES-Swift.h>
#import "RMOViewController.h"
#import <OpenGLES/ES2/glext.h>
#import "Geometry.h"

@class RMXDPad, RMOGeometry, RMXWorld, RMXShape, RMOShape, RMSParticle;


@interface RMOViewController (){
//    RMXDPad * _dPad;
    
   
    
//    GLKMatrix3 _normalMatrix;
    BOOL _initialized;
}

//@property NSMutableArray * shapes;
@end



@implementation RMOViewController


@synthesize vertexArray = _vertexArray;
- (RMOGeometry*)getGeometry:(id)shape { return nil; }
//@synthesize dPad = _dPad;
//- (RMXCamera*)camera {
//    return _dPad.activeCamera;
//}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    _context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    if (!_context) {
        NSLog(@"Failed to create ES context");
    }
    
    GLKView *view = (GLKView *) self.view;
    view.context = _context;
    view.drawableMultisample = GLKViewDrawableMultisample4X;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    
    self.projectionMatrix  = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), 4.0/3.0, 1, 51);
    
    [self initEffect];
    [self setupGL];
    
}

- (void)initEffect {
    _effect = [[GLKBaseEffect alloc] init];
    [self configureDefaultLight];
    _initialized = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//#pragma mark - Setup The Shader
//
//- (void)prepareEffectWithModelMatrix:(GLKMatrix4)modelMatrix viewMatrix:(GLKMatrix4)viewMatrix projectionMatrix:(GLKMatrix4)projectionMatrix{
//    _effect.transform.modelviewMatrix = GLKMatrix4Multiply(viewMatrix, modelMatrix);
//    _effect.transform.projectionMatrix = projectionMatrix;
//    [_effect prepareToDraw];
//}

- (void)configureDefaultLight{
    //Lightning
    _effect.light0.enabled = GL_TRUE;
    _effect.light0.ambientColor = GLKVector4Make(1, 1, 1, 1.0);
    _effect.light0.diffuseColor = GLKVector4Make(1, 1, 1, 1.0);
    _effect.light0.position = GLKVector4Make(0, 0,-10,1.0);
}

- (void)configureDefaultMaterial {
    
    _effect.texture2d0.enabled = NO;
    
    
    _effect.material.ambientColor = GLKVector4Make(0.3,0.3,0.3,1.0);
    _effect.material.diffuseColor = GLKVector4Make(0.3,0.3,0.3,1.0);
    _effect.material.emissiveColor = GLKVector4Make(0.0,0.0,0.0,1.0);
    _effect.material.specularColor = GLKVector4Make(0.0,0.0,0.0,1.0);
    
    _effect.material.shininess = 0;
}

- (void)configureDefaultTexture{
    _effect.texture2d0.enabled = YES;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"texture_numbers" ofType:@"png"];
    
    NSError *error;
    NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES]
                                                        forKey:GLKTextureLoaderOriginBottomLeft];
    
    
    self.textureInfo = [GLKTextureLoader textureWithContentsOfFile:path
                                                           options:options error:&error];
    if (self.textureInfo == nil)
        NSLog(@"Error loading texture: %@", [error localizedDescription]);
    
    
    GLKEffectPropertyTexture *tex = [[GLKEffectPropertyTexture alloc] init];
    tex.enabled = YES;
    tex.envMode = GLKTextureEnvModeDecal;
    tex.name = self.textureInfo.name;
    
    _effect.texture2d0.name = tex.name;
    
}
- (NSMutableArray*)shapes{ return [NSMutableArray new]; }
#pragma mark - OpenGL Setup
//NSMutableArray * cubes;
- (void)setupGL {
    
    [EAGLContext setCurrentContext:_context];
    
    glEnable(GL_DEPTH_TEST);
    glDepthFunc(GL_LEQUAL);
    
    // Enable Transparency
    glEnable (GL_BLEND);
    glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    
    
    // Create Vertex Array Buffer For Vertex Array Objects
    glGenVertexArraysOES(1, &_vertexArray);
    glBindVertexArrayOES(_vertexArray);
    
    
    // All of the following configuration for per vertex data is stored into the VAO
//    for (int i = 0; i<5; ++i ){
    // setup vertex buffer - what are my vertices?
    glGenBuffers(1, &_vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
    
    for (id p in self.shapes) {
        RMOGeometry* shape = [self getGeometry:p];
        glBufferData(GL_ARRAY_BUFFER, shape.sizeOfVertex, shape.vertices, GL_STATIC_DRAW);
        
        // setup index buffer - which vertices form a triangle?
        glGenBuffers(1, &_indexBuffer);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
        glBufferData(GL_ELEMENT_ARRAY_BUFFER, shape.sizeOfIndices, shape.indices, GL_STATIC_DRAW);
        
        //Setup Vertex Atrributs
        glEnableVertexAttribArray(GLKVertexAttribPosition);
        //SYNTAX -,number of elements per vertex, datatype, FALSE, size of element, offset in datastructure
        glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(Vertex), (const GLvoid *) offsetof(Vertex, Position));
        
        glEnableVertexAttribArray(GLKVertexAttribColor);
        glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(Vertex), (const GLvoid *) offsetof(Vertex, Color));
        
        //Textures
        glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
        glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(Vertex), (const GLvoid *) offsetof(Vertex, TexCoord));
        
        //Normals
        glEnableVertexAttribArray(GLKVertexAttribNormal);
        glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, sizeof(Vertex), (const GLvoid *) offsetof(Vertex, Normal));
        
        
        glActiveTexture(GL_TEXTURE0);
        [self configureDefaultTexture];
        
        
        // were done so unbind the VAO
        glBindVertexArrayOES(0);
    }
    
}

- (void)tearDownGL {
    
    [EAGLContext setCurrentContext:_context];
    
    glDeleteBuffers(1, &_vertexBuffer);
    glDeleteBuffers(1, &_indexBuffer);
    glDeleteVertexArraysOES(1, &_vertexArray);
    _effect = nil;
    
}

#pragma mark - OpenGL Drawing

- (void)update{
//    [_dPad animate];
//    self.projectionMatrix = [self.camera getProjectionMatrix:self.view.bounds.size.width height:self.view.bounds.size.height];
//    self.viewMatrix = _dPad.activeCamera.modelViewMatrix;
//    self.rotation += self.timeSinceLastUpdate * 0.5f;
}
/*
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClearColor(1.0, 1.0, 1.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    for (id p in self.shapes) {
        RMOGeometry* shape = [self getGeometry:p];
            
        GLKMatrix4 scaleMatrix = shape.scaleMatrix;
        GLKMatrix4 translateMatrix = shape.translationMatrix;
        GLKMatrix4 rotationMatrix = shape.rotationMatrix;// GLKMatrix4MakeRotation(self.rotation, 1.0, 1.0, 1.0);
        
        GLKMatrixStackRef matrixStack = GLKMatrixStackCreate(CFAllocatorGetDefault());
        
        GLKMatrixStackMultiplyMatrix4(matrixStack, translateMatrix);
        GLKMatrixStackMultiplyMatrix4(matrixStack, rotationMatrix);
        GLKMatrixStackMultiplyMatrix4(matrixStack, scaleMatrix);
        
        GLKMatrixStackPush(matrixStack);
        self.modelMatrix = GLKMatrixStackGetMatrix4(matrixStack);
        glBindVertexArrayOES(_vertexArray);
        [self prepareEffectWithModelMatrix:self.modelMatrix viewMatrix:self.viewMatrix projectionMatrix:self.projectionMatrix];
        //for (RMOGeometry* shape in _shapes) {
            glDrawElements(GL_TRIANGLES, (shape.sizeOfIndices / shape.sizeOfIZero), GL_UNSIGNED_BYTE, 0);
        
        glBindVertexArrayOES(0);
        
        CFRelease(matrixStack);
    }
    
}
*/
//- (void)doMatrixThings(GLKMatrix4 t,GLKMatrix4 s,GLKMatrix4 r);
@end
