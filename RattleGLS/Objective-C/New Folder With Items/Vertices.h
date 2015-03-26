//
//  Vertices.h
//  RattleGLES
//
//  Created by Max Bilbow on 24/03/2015.
//  Copyright (c) 2015 Rattle Media Ltd. All rights reserved.
//

#ifndef Vertices_h
#define Vertices_h
#endif

@import Foundation;
@import GLKit;

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
//
//@interface RMVertexWrapper : NSObject
//@property Vertex * v;
//@property unsigned char * i;
//@property int32_t sizeV;
//@property int32_t sizeI;
//
//
//+ (instancetype)CUBE;
//@end


extern long RMSizeOfVertexCube();
extern long RMSizeOfIndicesCube();
extern int RMSizeOfIZeroCube();

//extern const void * RMVerticesCubePtr();
//extern const void * RMIndicesCubePtr();

extern const Vertex VerticesCube[24];

extern const GLubyte IndicesTrianglesCube[36];

///Plane


extern const Vertex VerticesPlane[8];

extern const GLubyte IndicesTrianglesPlane[12];

