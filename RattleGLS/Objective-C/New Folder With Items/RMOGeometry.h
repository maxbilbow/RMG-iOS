//
//  RMOGeometry.h
//  RattleGLES
//
//  Created by Max Bilbow on 25/03/2015.
//  Copyright (c) 2015 Rattle Media Ltd. All rights reserved.
//

#ifndef RattleGLES_RMOGeometry_h
#define RattleGLES_RMOGeometry_h

@class RMXShape;

@interface RMOGeometry : NSObject
//var vertices: UnsafePointer<Float> { get set }
@property Vertex * vertices;
@property size_t sizeOfVertex;
@property GLubyte * indices;
@property GLsizei sizeOfIndices;
@property GLsizei sizeOfIZero;
@property RMXShape* parent;
//@property (readonly) GLKMatrix4 translationMatrix;
//@property (readonly) GLKMatrix4 scaleMatrix;
//@property (readonly) GLKMatrix4 rotationMatrix;
//+ (instancetype)CUBE:(RMXShape*)parent;
//@property NSMutableArray* verts;
@end

@interface RMOGeometry () {}
- (id)initWithShape:(RMXShape*)parent; 
+ (RMOGeometry*)RMO_PLANE:(RMXShape*)parent;
+ (RMOGeometry*)RMO_CUBE:(RMXShape*)parent;
//- (instancetype)initWithParent:(RMXShape*)parent vertex:(Vertex*)v indices(GLubyte*);
@end
//
#endif
