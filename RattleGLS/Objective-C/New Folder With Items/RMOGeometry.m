//
//  RMOGeometry.m
//  RattleGLES
//
//  Created by Max Bilbow on 25/03/2015.
//  Copyright (c) 2015 Rattle Media Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "Vertices.h"
#import "RMOGeometry.h"


@class RMXShape, RMOParticle, RMSParticle;





@interface RMOGeometry () {
    
}


@end

@implementation RMOGeometry



- (id)initWithShape:(RMXShape*)parent {
    self = [super init];
        self.parent = parent;
        self.vertices = VerticesCube;
        self.indices = IndicesTrianglesCube;
        self.sizeOfVertex = sizeof(VerticesCube);
        self.sizeOfIndices = sizeof(IndicesTrianglesCube);
        self.sizeOfIZero = sizeof(IndicesTrianglesCube[0]);
    return self;
}


+ (RMOGeometry*)RMO_PLANE:(RMXShape*)parent {
    RMOGeometry * geometry = [RMOGeometry new];
    geometry.parent = parent;
    geometry.sizeOfVertex = sizeof(VerticesPlane);
    geometry.sizeOfIndices = sizeof(IndicesTrianglesPlane);
    geometry.sizeOfIZero = sizeof(IndicesTrianglesPlane[0]);
    
    geometry.vertices = VerticesPlane; //malloc(geometry.sizeOfVertex);
    geometry.indices = IndicesTrianglesPlane; //malloc(geometry.sizeOfIndices);
    
    
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