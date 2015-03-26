//
//  Vetices.m
//  RattleGLES
//
//  Created by Max Bilbow on 24/03/2015.
//  Copyright (c) 2015 Rattle Media Ltd. All rights reserved.
//
//#import <GLKit/GLKit.h>
@import GLKit;
@import Foundation;
#import "Vertices.h"
//
//
//@implementation RMVertexWrapper
//
//+ (instancetype)CUBE{
//    RMVertexWrapper * vert = [RMVertexWrapper new];
//    vert.v = VerticesCube;
//    vert.i = IndicesTrianglesCube;
//    vert.sizeV = sizeof(VerticesCube);
//    vert.sizeI = sizeof(IndicesTrianglesCube);
//    return vert;
//}
//
//+ (instancetype)PLANE{
////    RMVertexWrapper * vert = [RMVertexWrapper new];
//    
//    return self.CUBE;
//}
//@end

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


/**
 Vertex for cube
 */
const Vertex VerticesCube[] = {
    // Front
    {{1, -1, 1},    {1, 0, 0, 1}, {0, 1},               {0, 0, 1}},
    {{1, 1, 1},     {0, 1, 0, 1}, {0, 2.0/3.0},         {0, 0, 1}},
    {{-1, 1, 1},    {0, 0, 1, 1}, {1.0/3.0, 2.0/3.0},   {0, 0, 1}},
    {{-1, -1, 1},   {0, 0, 0, 1}, {1.0/3.0, 1},         {0, 0, 1}},
    // Back
    {{1, 1, -1},    {1, 0, 0, 1}, {1.0/3.0, 1},         {0, 0, -1}},
    {{1, -1, -1},   {0, 0, 1, 1}, {1.0/3.0, 2.0/3.0},   {0, 0, -1}},
    {{-1, -1, -1},  {0, 1, 0, 1}, {2.0/3.0, 2.0/3.0},   {0, 0, -1}},
    {{-1, 1, -1},   {0, 0, 0, 1}, {2.0/3.0, 1},         {0, 0, -1}},
    // Left
    {{-1, -1, 1},   {1, 0, 0, 1}, {2.0/3.0, 1},         {-1, 0, 0}},
    {{-1, 1, 1},    {0, 1, 0, 1}, {2.0/3.0, 2.0/3.0},   {-1, 0, 0}},
    {{-1, 1, -1},   {0, 0, 1, 1}, {1, 2.0/3.0},         {-1, 0, 0}},
    {{-1, -1, -1},  {0, 0, 0, 1}, {1, 1},               {-1, 0, 0}},
    // Right
    {{1, -1, -1},   {1, 0, 0, 1}, {0, 2.0/3.0},         {1, 0, 0}},
    {{1, 1, -1},    {0, 1, 0, 1}, {0, 1.0/3.0},         {1, 0, 0}},
    {{1, 1, 1},     {0, 0, 1, 1}, {1.0/3.0, 1.0/3.0},   {1, 0, 0}},
    {{1, -1, 1},    {0, 0, 0, 1}, {1.0/3.0, 2.0/3.0},   {1, 0, 0}},
    // Top
    {{1, 1, 1},     {1, 0, 0, 1}, {1.0/3.0, 2.0/3.0},   {0, 1, 0}},
    {{1, 1, -1},    {0, 1, 0, 1}, {1.0/3.0, 1.0/3.0},   {0, 1, 0}},
    {{-1, 1, -1},   {0, 0, 1, 1}, {2.0/3.0, 1.0/3.0},   {0, 1, 0}},
    {{-1, 1, 1},    {0, 0, 0, 1}, {2.0/3.0, 2.0/3.0},   {0, 1, 0}},
    // Bottom
    {{1, -1, -1},   {1, 0, 0, 1}, {2.0/3.0, 2.0/3.0},   {0, -1, 0}},
    {{1, -1, 1},    {0, 1, 0, 1}, {2.0/3.0, 1.0/3.0},   {0, -1, 0}},
    {{-1, -1, 1},   {0, 0, 1, 1}, {1, 1.0/3.0},         {0, -1, 0}},
    {{-1, -1, -1},  {0, 0, 0, 1}, {1, 2.0/3.0},         {0, -1, 0}}
};

const GLubyte IndicesTrianglesCube[] = {
    // Front
    0, 1, 2,
    2, 3, 0,
    // Back
    4, 6, 5,
    4, 6, 7,
    // Left
    8, 9, 10,
    10, 11, 8,
    // Right
    12, 13, 14,
    14, 15, 12,
    // Top
    16, 17, 18,
    18, 19, 16,
    // Bottom
    20, 21, 22,
    22, 23, 20
};

///Plane


const Vertex VerticesPlane[] = {
    // Top
    {{1, 0, 1},     {1, 0, 0, 1}, {1.0/3.0, 2.0/3.0},   {0, 1, 0}},
    {{1, 0, -1},    {0, 1, 0, 1}, {1.0/3.0, 1.0/3.0},   {0, 1, 0}},
    {{-1, 0, -1},   {0, 0, 1, 1}, {2.0/3.0, 1.0/3.0},   {0, 1, 0}},
    {{-1, 0, 1},    {0, 0, 0, 1}, {2.0/3.0, 2.0/3.0},   {0, 1, 0}},
    // Bottom
    {{1, 0, 1},     {1, 0, 0, 1}, {1.0/3.0, 2.0/3.0},   {0, -1, 0}},
    {{1, 0, -1},    {0, 1, 0, 1}, {1.0/3.0, 1.0/3.0},   {0, -1, 0}},
    {{-1, 0, -1},   {0, 0, 1, 1}, {2.0/3.0, 1.0/3.0},   {0, -1, 0}},
    {{-1, 0, 1},    {0, 0, 0, 1}, {2.0/3.0, 2.0/3.0},   {0, -1, 0}},
};

const GLubyte IndicesTrianglesPlane[] = {
    // Top
    0, 1, 2,
    2, 3, 0,
    // Bottom
    4, 6, 5,
    4, 6, 7,
};

