//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//



#import "Vertices.h"
GLsizei RMSizeOfVert();
const GLvoid * RMOffsetVertCol();
const GLvoid * RMOffsetVertTex();
const GLvoid * RMOffsetVertNorm();
const GLvoid * RMOffsetVertPos();
NSString * RMOPathForResource(NSString* path, NSString* ofType);

// long RMSizeOfVertexCube();
// long RMSizeOfIndicesCube();
// int RMSizeOfIZeroCube();
// const void * RMVerticesCubePtr();
// const void * RMIndicesCubePtr();
//
//
//long RMSizeOfVertexPlane();
//long RMSizeOfIndicesPlane();
//int RMSizeOfIZeroPlane();
//const void * RMVerticesPlanePtr();
//const void * RMIndicesPlanePtr();
//
//


const int RMX_NULL, RMX_CUBE, RMX_PLANE,  RMX_SPHERE;

long RMSizeOfVertex(GLsizei type);
long RMSizeOfIndices(int type);
int RMSizeOfIZero(int type);

const void * RMVerticesPtr(int type);
const void * RMIndicesPtr(int type);

