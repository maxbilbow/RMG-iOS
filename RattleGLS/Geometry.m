//
//  Geometry.m
//  OpenGL Visible Surface Demo
//
//  Created by Christoph Halang on 28/02/15.
//  Copyright (c) 2015 Christoph Halang. All rights reserved.
//

@class RMXShape, RMOParticle, RMSParticle;
#import <RattleGLES-Swift.h>
#import <GLKit/GLKit.h>
#import "Vertices.h"
#import "Geometry.h"

// the vertex data consists of Position, Color, Texture Coordinates and Normal



@interface RMOGeometry () {
    
}
//@property NSString * type;
//@property size_t sizeOfVertex;
//@property GLsizei sizeOfIndices;
//@property GLsizei sizeOfIZero;
//@property Vertex * vertices;
//@property GLubyte * indices;


@end

@implementation RMOGeometry



+ (RMOGeometry*)RMO_PLANE:(RMXShape*)parent {
    RMOGeometry * geometry = [RMOGeometry new];
    geometry.parent = parent;
    geometry.sizeOfVertex = sizeof(VerticesPlane);
    geometry.sizeOfIndices = sizeof(IndicesTrianglesPlane);
    geometry.sizeOfIZero = sizeof(IndicesTrianglesPlane[0]);
    
    geometry.vertices = VerticesPlane; //malloc(geometry.sizeOfVertex);
    geometry.indices = IndicesTrianglesPlane; //malloc(geometry.sizeOfIndices);
//    memcpy(geometry.vertices, VerticesPlane, geometry.sizeOfVertex);
//    memcpy(geometry.indices,IndicesTrianglesPlane,geometry.sizeOfIndices);
    return geometry;
}

+ (RMOGeometry*)RMO_CUBE:(RMXShape*)parent{
    RMOGeometry * geometry = [RMOGeometry new];
    geometry.parent = parent;
    geometry.sizeOfVertex = sizeof(VerticesCube);
    geometry.sizeOfIndices = sizeof(IndicesTrianglesCube);
    geometry.sizeOfIZero = sizeof(IndicesTrianglesCube[0]);
    
    geometry.vertices = VerticesCube;// malloc(geometry.sizeOfVertex);
    geometry.indices = IndicesTrianglesCube;// malloc(geometry.sizeOfIndices);
//    memcpy(geometry.vertices, VerticesCube, geometry.sizeOfVertex);
//    memcpy(geometry.indices,IndicesTrianglesCube,geometry.sizeOfIndices);
    return geometry;
}

@end