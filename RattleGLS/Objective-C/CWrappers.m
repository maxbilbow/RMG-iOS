//
//  CWrappers.m
//  RattleGLES
//
//  Created by Max Bilbow on 24/03/2015.
//  Copyright (c) 2015 Rattle Media Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

#import "Vertices.h"

const GLvoid * RMOffsetVertCol() {
    return (const GLvoid * ) offsetof(Vertex, Color);
}

const GLvoid * RMOffsetVertTex(){
    return (const GLvoid *) offsetof(Vertex, TexCoord);
}

const GLvoid * RMOffsetVertNorm(){
    return (const GLvoid *) offsetof(Vertex, Normal);
}

const GLvoid * RMOffsetVertPos() {
    return (const GLvoid *) offsetof(Vertex, Position);
}
GLsizei RMSizeOfVert(){
    return sizeof(Vertex);
}

NSString * RMOPathForResource(NSString* path, NSString* ofType) {
    return [[NSBundle mainBundle] pathForResource:@"texture_numbers" ofType:@"png"];
}



GLsizeiptr RMSizeOfVertexCube(){
    return sizeof(VerticesCube);
}

GLintptr RMSizeOfIndicesCube(){
    return sizeof(IndicesTrianglesCube);
}

GLsizei RMSizeOfIZeroCube(){
    return sizeof(IndicesTrianglesCube[0]);
}

const void * RMVerticesCubePtr(){
    return VerticesCube;
}

const void * RMIndicesCubePtr() {
    return IndicesTrianglesCube;
}


const int RMX_NULL = 0, RMX_CUBE = 1, RMX_PLANE = 2,  RMX_SPHERE = 3;

long RMSizeOfVertex(int type){
    switch (type){
        case RMX_PLANE:
            return sizeof(VerticesPlane);
        case RMX_SPHERE:
            return sizeof(VerticesSphere);
        case RMX_CUBE:
        default:
            return sizeof(VerticesCube);
    }
}

long RMSizeOfIndices(int type){
    switch (type){
        case RMX_PLANE:
            return sizeof(IndicesTrianglesPlane);
        case RMX_SPHERE:
            return sizeof(IndicesTrianglesSphere);
        case RMX_CUBE:
        default:
            return sizeof(IndicesTrianglesCube);
    }

    
    
}
int RMSizeOfIZero(int type){
    switch (type){
        case RMX_PLANE:
            return sizeof(IndicesTrianglesPlane[0]);
        case RMX_SPHERE:
            return IndicesTrianglesSphere[0];
        case RMX_CUBE:
        default:
            return sizeof(IndicesTrianglesCube[0]);
    }
}

const void * RMVerticesPtr(int type){
    switch (type){
        case RMX_PLANE:
            return VerticesPlane;
        case RMX_SPHERE:
            return VerticesSphere;
        case RMX_CUBE:
        default:
            return VerticesCube;
    }

    
}

const void * RMIndicesPtr(int type){
    switch (type){
        case RMX_PLANE:
            return IndicesTrianglesPlane;
        case RMX_SPHERE:
            return IndicesTrianglesSphere;
        case RMX_CUBE:
        default:
            return IndicesTrianglesCube;
    }
    
}

