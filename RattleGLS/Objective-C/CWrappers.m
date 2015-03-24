//
//  CWrappers.m
//  RattleGLES
//
//  Created by Max Bilbow on 24/03/2015.
//  Copyright (c) 2015 Rattle Media Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "Geometry.h"

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
