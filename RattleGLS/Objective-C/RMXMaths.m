//
//  Maths.h
//  OpenGL 2.0
//
//  Created by Max Bilbow on 20/02/2015.
//  Copyright (c) 2015 Rattle Media Ltd. All rights reserved.
//

//#include <SceneKit/SceneKit.h>
#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import <complex.h>

#import <math.h>
#import <SceneKit/SceneKit.h>
#import "RMXMaths.h"


BOOL RMXVector3IsZero(RMXVector3 v)
{
    return ((v.x==0)&&(v.y==0)&&(v.z==0));
}




float RMXGetSpeed(RMXVector3 v){
    float squared = v.x*v.x + v.y*v.y + v.z*v.z;
    return sqrtf(squared);
}


RMXVector3 RMXVector3Abs(RMXVector3 v){
    return GLKVector3Make(fabs(v.x),fabs(v.y),fabs(v.z));
}
/*
SCNPhysicsBody RMXPhyisicsBodyMake() {//float m, float r){
    RMXPhysicsBody b;
    b.position = SCNVector3Make(0,0,0);
    b.velocity = SCNVector3Make(0,0,0);
    b.acceleration = SCNVector3Make(0,0,0);
    b.forces = SCNVector3Make(0,0,0);
    b.orientation = SCNMatrix4Identity;
    
    b.vMatrix = GLKMatrix3Make(
                               0,0,0,
                               0,0,0,
                               0,0,0
                               );
//    b.angles.theta = b.angles.phi = 0;
//    b.mass = m;
//    b.radius = r;
//    b.dragC = 0.5;
//    b.dragArea = r*r * PI;
    return b;
}
*/
RMXVector3 RMXVector3DivideByScalar(RMXVector3 v, float s){
    //vector_float3 fv = SCNVector3ToFloat3(v);
    for (int i=0; i<3;++i){
        //if (abs(v.v[i]) < 0.01SCNVector3Make)
            v.v[i] /= s;
    }
    return v;
}

void RMXVector3RoundToZero(GLKVector3 * v, float dp){
    for (int i=0; i<3;++i){
        if (fabsf(v->v[i]) < dp)
            v->v[i] = 0;
    }
}

RMXVector3 RMXVector3Divide(RMXVector3 vTop, RMXVector3 vBottom){
//    vector_float3 top = SCNVector3ToFloat3(vTop);
//    vector_float3 bottom = SCNVector3ToFloat3(vBottom);
    for (int i=0; i<3;++i){
        vTop.v[i] /= vBottom.v[i];
    }
    return vTop;//(top);
}

RMXVector3 RMXVector3DivideScalar(RMXVector3 top, float bottom){
//    vector_float3 fv = SCNVector3ToFloat3(top);
    for (int i=0; i<3;++i){
        top.v[i] /= bottom;
    }
    return top;//SCNVector3FromFloat3(fv);
}

RMXVector3 RMXVector3Add(RMXVector3 a ,RMXVector3 b){
    return GLKVector3Add(a,b);
//    return SCNVector3Make(a.x + b.x,
//                          a.y + b.y,
//                          a.z + b.z
//                          );
}

RMXVector3 RMXVector3Add3(RMXVector3 a ,RMXVector3 b, RMXVector3 c ){
//    return SCNVector3Make(a.x + b.x + c.x,
//                          a.y + b.y + c.y,
//                          a.z + b.z + c.z);
    return GLKVector3Add(a,GLKVector3Add(b,c));
}



RMXVector3 RMXVector3Add4(RMXVector3 a ,RMXVector3 b, RMXVector3 c , RMXVector3 d){
//    return SCNVector3Make(a.x + b.x + c.x + d.x,
//                          a.y + b.y + c.y + d.y,
//                          a.z + b.z + c.z + d.z);

    return RMXVector3Add(RMXVector3Add3(a,b,c),d);
}


RMXVector3 RMXVector3AddScalar(RMXVector3 inOut, float s ){
    inOut.x += s;
    inOut.y += s;
    inOut.z += s;
    return inOut;
}

RMXVector3 RMXVector3MultiplyScalarAndSpeed(RMXVector3 v, float s){
    return GLKVector3MultiplyScalar(RMXVector3Abs(v),s*RMXGetSpeed(v));
}

RMXVector3 RMXVector3MultiplyScalar(RMXVector3 v, float s){
    return GLKVector3MultiplyScalar(v,s);
}
RMXVector3 RMXVector3Zero(){
    return GLKVector3Make(0,0,0);
}


RMXVector3 RMXMatrix3MultiplyScalarAndSpeed(RMXMatrix3 m, float s){
    GLKVector3 result[3];
    for (int i=0;i<0;++i){
        RMXVector3 v = GLKMatrix3GetRow(m,i);
        result[i] = RMXVector3MultiplyScalarAndSpeed( v , s );
    }
    
    return GLKMatrix3MultiplyVector3(GLKMatrix3MakeWithRows(result[0],result[1],result[2]),GLKVector3Make(1,1,1));
}

RMXVector3 RMXMatrix4MultiplyVector3(RMXMatrix4 m, RMXVector3 s){
    return GLKMatrix4MultiplyVector3(m,s);
}



RMXVector3 RMXScaler3FromVector3(RMXVector3 x, RMXVector3 y, RMXVector3 z){
    return GLKVector3Make(RMXGetSpeed(x),RMXGetSpeed(y),RMXGetSpeed(z));
}

RMXVector3 RMXScaler3FromMatrix3(RMXMatrix3 m){
    return GLKVector3Make( RMXGetSpeed(GLKMatrix3GetRow(m,0))
                          ,RMXGetSpeed(GLKMatrix3GetRow(m,1))
                          ,RMXGetSpeed(GLKMatrix3GetRow(m,2))
                          );
}

RMXMatrix3 RMXMatrix3RotateAboutY(float theta, RMXMatrix3  matrix){
    
   return GLKMatrix3RotateWithVector3(matrix, theta, GLKVector3Make(0,1,0));

}

RMXVector3 RMXMatrix3MultiplyVector3(RMXMatrix3 matrixLeft, RMXVector3 vectorRight){
    return GLKMatrix3MultiplyVector3(matrixLeft, vectorRight);
}



void RMXPrintMatrix(GLKMatrix4 m){
    
}

void RMXVector3SetX(RMXVector3 * v, float x){
    v->x = x;
}

void RMXVector3SetY(RMXVector3 * v, float y){
    v->y = y;
}

void RMXVector3SetZ(RMXVector3 * v, float z){
    v->z = z;
}

SCNMatrix4 SCNMatrix4Transpose(SCNMatrix4 m){
    return SCNMatrix4FromGLKMatrix4(GLKMatrix4Transpose(SCNMatrix4ToGLKMatrix4(m)));
}

SCNVector3 SCNMatrix3MultiplyVector3(SCNMatrix4 ml, RMXVector3 vectorRight)
{
    GLKMatrix4 matrixLeft = SCNMatrix4ToGLKMatrix4(ml);
    // GLKVector3 vectorRight = SCNVector3ToGLKVector3(vr);
    SCNVector3 v = SCNVector3Make(
        matrixLeft.m[0] * vectorRight.v[0] + matrixLeft.m[1] * vectorRight.v[0] + matrixLeft.m[0] * vectorRight.v[0],
        matrixLeft.m[3] * vectorRight.v[1] + matrixLeft.m[4] * vectorRight.v[1] + matrixLeft.m[1] * vectorRight.v[2],
        matrixLeft.m[6] * vectorRight.v[2] + matrixLeft.m[7] * vectorRight.v[2] + matrixLeft.m[2] * vectorRight.v[2] );
    return v;
}
