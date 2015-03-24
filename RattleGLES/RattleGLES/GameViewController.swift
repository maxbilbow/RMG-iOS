//
//  GameViewController.swift
//  RattleGLES
//
//  Created by Max Bilbow on 23/03/2015.
//  Copyright (c) 2015 Rattle Media Ltd. All rights reserved.
//

class GameViewController : GLKViewController {
    
    var modelMatrix, viewMatrix, projectionMatrix: GLKMatrix4!
    var textureInfo: GLKTextureInfo! = nil
    var rotation: Float = 0
    var vertexArray: UnsafeMutablePointer<GLuint> = UnsafeMutablePointer<GLuint>.alloc(sizeof(GLuint64))
    var context: EAGLContext! = nil
    var effect: GLKBaseEffect! = nil
    var vertexBuffer: UnsafeMutablePointer<GLuint> = UnsafeMutablePointer<GLuint>.alloc(sizeof(GLuint64))
    var indexBuffer: UnsafeMutablePointer<GLuint> = UnsafeMutablePointer<GLuint>.alloc(sizeof(GLuint64))
    var initialized: Bool = false
    
    lazy var dPad: RMXDPad = RMXDPad.New(self)
    
    var shapes: NSMutableArray {
        return self.dPad.world.shapes
    }
    
    var camera: RMXCamera {
        return self.dPad.activeCamera
    }
    
    override func viewDidLoad() {
        self.viewMatrix = self.dPad.activeCamera.modelViewMatrix
        self.context = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
        if (self.context == nil) {
            NSLog("Failed to create ES context")
        }
        let view = self.view as! GLKView
        view.context = self.context
        view.drawableMultisample = GLKViewDrawableMultisample.Multisample4X
        view.drawableDepthFormat = GLKViewDrawableDepthFormat.Format24
        
        self.projectionMatrix  = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0), 4.0/3.0, 1, 51)
        
        self.initEffect()
        self.setupGL()

        super.viewDidLoad()
        
    }
    
    func initEffect() {
        self.effect = GLKBaseEffect()
        self.configureDefaultLight()
        self.initialized = true
    
    }
    func update(){
        self.dPad.animate()
        self.projectionMatrix = self.camera.getProjectionMatrix(Float(self.view.bounds.size.width), height: Float(self.view.bounds.size.height))
        self.viewMatrix = self.dPad.activeCamera.modelViewMatrix
        self.rotation += Float(self.timeSinceLastUpdate * 0.5)
        //super.update()
    }
    
    
    func setupGL() {
        EAGLContext.setCurrentContext(self.context)
        
        glEnable(GLenum(GL_DEPTH_TEST))
        glDepthFunc(GLenum(GL_LEQUAL))
        
        // Enable Transparency
        glEnable (GLenum(GL_BLEND))
        glBlendFunc (GLenum(GL_SRC_ALPHA), GLenum(GL_ONE_MINUS_SRC_ALPHA))
        
        
        // Create Vertex Array Buffer For Vertex Array Objects
        glGenVertexArraysOES(1, self.vertexArray)
        glBindVertexArrayOES(self.vertexArray.memory);
        
        
        // All of the following configuration for per vertex data is stored into the VAO
        
        // setup vertex buffer - what are my vertices?
        glGenBuffers(1, self.vertexBuffer)
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), self.vertexBuffer.memory);
        
        for p in self.dPad.world.sprites {
            if let shape = p.geometry {
                let shape = p.geometry!
                glBufferData(GLenum(GL_ARRAY_BUFFER), shape.sizeOfVertex, shape.vertices, GLenum(GL_STATIC_DRAW))
                
                // setup index buffer - which vertices form a triangle?
                glGenBuffers(1, self.indexBuffer);
                glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), self.indexBuffer.memory)
                glBufferData(GLenum(GL_ELEMENT_ARRAY_BUFFER), GLintptr(shape.sizeOfIndices), shape.indices, GLenum(GL_STATIC_DRAW))
                
                //Setup Vertex Atrributs
                glEnableVertexAttribArray(GLuint(GLKVertexAttrib.Position.rawValue))
                //SYNTAX -,number of elements per vertex, datatype, FALSE, size of element, offset in datastructure
                glVertexAttribPointer(GLuint(GLKVertexAttrib.Position.rawValue), GLint(3), GLenum(GL_FLOAT), GLboolean(GL_FALSE), RMSizeOfVert(), RMOffsetVertPos())
                
                glEnableVertexAttribArray(GLuint(GLKVertexAttrib.Color.rawValue))
                glVertexAttribPointer(GLuint(GLKVertexAttrib.Color.rawValue), 4, GLenum(GL_FLOAT), GLboolean(GL_FALSE), RMSizeOfVert(), RMOffsetVertCol() )
                
                //Textures
                glEnableVertexAttribArray(GLuint(GLKVertexAttrib.TexCoord0.rawValue))
                glVertexAttribPointer(GLuint(GLKVertexAttrib.TexCoord0.rawValue), 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), RMSizeOfVert(), RMOffsetVertTex())
                
                //Normals
                glEnableVertexAttribArray(GLuint(GLKVertexAttrib.Normal.rawValue))
                glVertexAttribPointer(GLuint(GLKVertexAttrib.Normal.rawValue), 3, GLenum(GL_FLOAT), GLboolean(GL_FALSE), RMSizeOfVert(), RMOffsetVertNorm());
                
                
                glActiveTexture(GLenum(GL_TEXTURE0))
                self.configureDefaultTexture()
                
                
                // were done so unbind the VAO
                glBindVertexArrayOES(0);
            }
        }
    }
    
    
    func configureDefaultLight() {
        //Lightning
        self.effect.light0.enabled = GLboolean(1)
        self.effect.light0.ambientColor = GLKVector4Make(1, 1, 1, 1.0)
        self.effect.light0.diffuseColor = GLKVector4Make(1, 1, 1, 1.0)
        self.effect.light0.position = GLKVector4Make(0, 0,-10,1.0)
    }
    
    func configureDefaultMaterial() {
        self.effect.texture2d0.enabled = GLboolean(0)
        self.effect.material.ambientColor = GLKVector4Make(0.3,0.3,0.3,1.0)
        self.effect.material.diffuseColor = GLKVector4Make(0.3,0.3,0.3,1.0)
        self.effect.material.emissiveColor = GLKVector4Make(0.0,0.0,0.0,1.0)
        self.effect.material.specularColor = GLKVector4Make(0.0,0.0,0.0,1.0)
        self.effect.material.shininess = 0
    }
    
    func configureDefaultTexture() {
        self.effect.texture2d0.enabled = GLboolean(1)
        
        let path = RMOPathForResource("texture_numbers", "png")
        
        var error: NSErrorPointer = NSErrorPointer()
        let options: [NSObject : AnyObject] = NSDictionary(object: NSNumber(bool:true),forKey:GLKTextureLoaderOriginBottomLeft) as [NSObject : AnyObject]
        
        
        self.textureInfo = GLKTextureLoader.textureWithContentsOfFile(path, options: options, error: error)
        if self.textureInfo == nil {
            NSLog("Error loading texture: %@", error.debugDescription)
        }
        
        
        let tex = GLKEffectPropertyTexture()
        tex.enabled = GLboolean(1)
        tex.envMode = GLKTextureEnvMode.Decal
        tex.name = self.textureInfo.name
        
        self.effect.texture2d0.name = tex.name;
    
    }

    override func glkView(view: GLKView!, drawInRect rect: CGRect) {
        glClearColor(1.0, 1.0, 1.0, 1.0);
        glClear(GLenum(GL_COLOR_BUFFER_BIT) | GLenum(GL_DEPTH_BUFFER_BIT));
        
        for p in self.dPad.world.sprites {
            
            if let shape = p.geometry { if p.shape != nil {
                let shape = p.geometry
                let scaleMatrix = shape!.scaleMatrix
                let translateMatrix = shape!.translationMatrix
                let rotationMatrix = shape!.rotationMatrix
                
                
                var matrixStack = GLKMatrixStackCreate(kCFAllocatorDefault).takeRetainedValue()
                
                GLKMatrixStackMultiplyMatrix4(matrixStack, translateMatrix)
                GLKMatrixStackMultiplyMatrix4(matrixStack, rotationMatrix)
                GLKMatrixStackMultiplyMatrix4(matrixStack, scaleMatrix)
                
                GLKMatrixStackPush(matrixStack)
                self.modelMatrix = GLKMatrixStackGetMatrix4(matrixStack);
                glBindVertexArrayOES(self.vertexArray.memory)
                self.prepareEffectWithModelMatrix(self.modelMatrix, viewMatrix:self.viewMatrix, projectionMatrix: self.projectionMatrix)
                glDrawElements(GLenum(GL_TRIANGLES), GLsizei(shape!.sizeOfIndices / shape!.sizeOfIZero), GLenum(GL_UNSIGNED_BYTE), UnsafePointer<Void>())//nil or 0?
                
                glBindVertexArrayOES(0)
                
                }}
            
            //            CFRelease(matrixStack as! GLKMatrixStackRef);
        }
    }
    
    func prepareEffectWithModelMatrix(modelMatrix: GLKMatrix4, viewMatrix:GLKMatrix4, projectionMatrix: GLKMatrix4) {
        self.effect.transform.modelviewMatrix = GLKMatrix4Multiply(viewMatrix, modelMatrix)
        self.effect.transform.projectionMatrix = projectionMatrix;
        self.effect.prepareToDraw()
    }
    
    override func didReceiveMemoryWarning() {
        //TODO:
    }
    
    func tearDownGL() {
        EAGLContext.setCurrentContext(self.context)
        glDeleteBuffers(1, self.vertexBuffer)
        glDeleteBuffers(1, self.indexBuffer)
        glDeleteVertexArraysOES(1, self.vertexArray)
        self.effect = nil
    }
    
}