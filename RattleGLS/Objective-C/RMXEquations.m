//
//  RMXEquations.h
//  OpenGL 2.0
//
//  Created by Max Bilbow on 22/02/2015.
//  Copyright (c) 2015 Rattle Media Ltd. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import <complex.h>
#import <math.h>
#import "RMXMaths.h"
#import "RMXEquations.h"



GLKVector4 doASum(float radius, int i, int noOfShapes ){
    radius = ceil(radius);
    return GLKVector4Make(RMXRandomFloat(radius*2)-radius,RMXRandomFloat(2*radius),RMXRandomFloat(radius*2)-radius, RMXRandomFloat(radius));
    
}

float RMXRandomFloat(int radius){
    return (rand() % radius);
}

GLKVector4 RMXSomeCircle (float i, float r){
    
    return  GLKVector4Make(sin(i)*sin(i)*r, sin(i)*cos(i)*r, cos(i)*cos(i)*r,1);
    
}
GLKVector4 randomSpurt (float i){
    GLKVector4 result = GLKVector4Make((rand() % 360 + i),(rand() % 360 + i),(rand() % 360 + i),(rand() % 360 + 10));
    return result;
}

float rmxEquateContours(float x, float y){
    return x+y;//((x*x +3*y*y) / 0.1 * 50*50 ) + (x*x +5*y*y)*exp2f(1-50*50)/2;
}

float rmxEquateCircle(float x, float y, float r, float plane){
    
    return sqrt(x*x+y*y);//((x*x +3*y*y) / 0.1 * 50*50 ) + (x*x +5*y*y)*exp2f(1-50*50)/2;
}


GLKVector4 point_on_circle ( double radius, double angle_in_degrees,  double centre)
{
    GLKVector4 result;
    
    result.x = centre + radius * cexp ( PI * I * ( angle_in_degrees  / 180.0 ) );
    result.y = 0;
    result.z = centre + radius * cexp ( PI * I * ( angle_in_degrees  / 180.0 ) );
    return result;
}

