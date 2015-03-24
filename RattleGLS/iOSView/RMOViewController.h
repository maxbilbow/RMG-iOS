//
//  GameViewController.h
//  RMX-ES
//
//  Created by Max Bilbow on 23/03/2015.
//  Copyright (c) 2015 Rattle Media. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

@class RMXDPad;
@interface RMOViewController : GLKViewController
//@property RMXDPad* dPad;

@property GLKMatrix4 modelMatrix; // transformations of the model
@property GLKMatrix4 viewMatrix; // camera position and orientation
@property GLKMatrix4 projectionMatrix; // view frustum (near plane, far plane)
@property GLKTextureInfo* textureInfo;
@property (readonly) NSMutableArray * shapes;
@property float rotation;
@property GLuint vertexArray;
@property EAGLContext* context;
@property GLKBaseEffect* effect;
@property GLuint vertexBuffer;
@property GLuint indexBuffer;

- (void)update;
- (RMOGeometry*)getGeometry:(id)shape;
@end
