//
//  Geometry.h
//  OpenGL Visible Surface Demo
//
//  Created by Christoph Halang on 28/02/15.
//  Copyright (c) 2015 Christoph Halang. All rights reserved.
//


#ifndef Geometry_h
#define Geometry_h

#import "GLKit/GLKit.h"
//#import "Vertices.h"


typedef struct {
    float Position[3];
    float Color[4];
    float TexCoord[2];
    float Normal[3];
    
}Vertex;

typedef struct{
    int x;
    int y;
    int z;
} Position;



@class RMXShape;

@interface RMOGeometry : NSObject
    //var vertices: UnsafePointer<Float> { get set }
@property Vertex * vertices;
@property size_t sizeOfVertex;
@property GLubyte * indices;
@property GLsizei sizeOfIndices;
@property GLsizei sizeOfIZero;
@property (readonly) GLKMatrix4 translationMatrix;
@property (readonly) GLKMatrix4 scaleMatrix;
@property (readonly) GLKMatrix4 rotationMatrix;
//+ (instancetype)CUBE:(RMXShape*)parent;
//@property NSMutableArray* verts;
@end

@interface RMOGeometry () {}
//- (instancetype)initWithParent:(RMXShape*)parent;
+ (RMOGeometry*)RMO_PLANE:(RMXShape*)parent;
+ (RMOGeometry*)RMO_CUBE:(RMXShape*)parent;
//- (instancetype)initWithParent:(RMXShape*)parent vertex:(Vertex*)v indices(GLubyte*);
@end
//


#endif
