//
//  cStuff.c
//  RattleGL
//
//  Created by Max Bilbow on 11/03/2015.
//  Copyright (c) 2015 Rattle Media. All rights reserved.
//
//
@import Foundation;
//@import GLUT;
@import GLKit;
//#import <GLUT/GLUT.h>
//#import <GLKit/GLKit.h>
//#import <OpenGL/OpenGL.h>
//#import <SceneKit/SceneKit.h>
//#import <GLUT/glut.h>
#import "RMXMaths.h"
#import <RattleGLES-Swift.h>
#import "cStuff.h"

//class RMXGL {
//public:
     void RMXMakeLookAtGL(void (* lookAt)(double eyeX, double eyeY, double eyez,
                                         double centerX, double centerY, double centerZ,
                                         double upX, double upY, double upZ),double eyeX, double eyeY, double eyez,
                         double centerX, double centerY, double centerZ,
                         double upX, double upY, double upZ) { 
        lookAt(eyeX,eyeY,eyez,
               centerX,centerY,centerZ,
               upX,upY,upZ);
        
    }

     void RMXGLKMakeLookAt(GLKBaseEffect * effect,RMXCamera * view) {
//        effect.transform.modelviewMatrix = GLKMatrix4MakeLookAt(view.eye.x, view.eye.y, view.eye.z,
//                                     view.center.x, view.center.y, view.center.z,
//                                     view.up.x, view.up.y, view.up.z );
    }


/**
@brief Use it to write a short description about the method, property, class, file, struct, or enum you’re documenting. No line breaks are allowed.
@discussion Use it to write a thorough description. You can add line breaks if needed.
@param view this you can describe a parameter of a method or function. You can have multiple such tags.
@return Use it to specify the return value of a method or function.
@see Use it to indicate other related method or functions. You can have multiple such tags.
@sa Similar to the previous one.
@code With this tag, you can embed code snippets in the documentation. When viewing the documentation in Help Inspector, the code is represented with a different font, inside a special box. Always use the @endcode tag when you finish writing code.
@remark Use it to highlight any special facts about the code you’re currently documenting.
 */


int RMXGLMakeLookAt(RMXCamera * view) {
    #ifdef GLUT
    gluLookAt(view.eye.x, view.eye.y, view.eye.z,
              view.center.x, view.center.y, view.center.z,
              view.up.x, view.up.y, view.up.z );
     #endif
     return 0;

}


void RMXGLMaterialfv(int32_t a,int32_t b, GLKVector4 color){
    #ifdef GLUT
    glMaterialfv(a,b,color.v);
    #endif
}

void RMXGLTranslate(RMXVector3 v){
     #ifdef GLUT
    glTranslatef(v.x, v.y, v.z);
    #endif
}

void RMXGLShine(int32_t a, int32_t b, GLKVector4 color) {
    #ifdef GLUT
    glLightfv(a, b, color.v);
#endif

}

 void RMXGLRender(void (*render)(float),float size) {
     #ifdef GLUT
    render(size);
#endif
}

 void RMXGLCenter(void (*center)(int,int),int x, int y){
     #ifdef GLUT
    center(x,y);
#endif
}

 void RMXCGGetLastMouseDelta(int * x, int * y) {
     #ifdef GLUT
    CGGetLastMouseDelta(x,y);
#endif
}

 GLKVector4 RMXRandomColor() {
    //float rCol[4];
    GLKVector4 rCol = GLKVector4Make(0,0,0,0);
    //rCol.x = (rand() % 100)/10;
    for (int i = 0; i<3; ++i)
        rCol.v[i] = (rand() % 800)/500;
        
        rCol.v[3] = 1.0;//{ ( ,(rand() % 100)/10,(rand() % 100)/10, 1.0 };
        //if (rCol.v[2] == rCol.z) NSLog(@"Fuck me!");
        return rCol;
}

 void RMXGLPostRedisplay(){
     #ifdef GLUT
    glutPostRedisplay();
#endif
}

 void RMXGLMakePerspective(float fovy, float aspect, float near, float far){
     #ifdef GLUT
    gluPerspective(fovy, aspect, near, far);
#endif
}

 void RMXGlutSwapBuffers(){
     #ifdef GLUT
    glutSwapBuffers();
#endif
}

 void RMXGlutInit(int argc, char * argv[]){
     #ifdef GLUT
    glutInit(&argc, argv);
#endif
}

 void RMXGlutInitDisplayMode(unsigned int mode){
     #ifdef GLUT
    glutInitDisplayMode(mode);
#endif
}
 void RMXGlutEnterGameMode(){
     #ifdef GLUT
    glutEnterGameMode();
#endif
}

 void RMXGlutMakeWindow(int posx,int posy, int w, int h, const char * name){
     #ifdef GLUT
    glutInitWindowPosition(posx,posy);
    glutInitWindowSize(w,h);
    glutCreateWindow(name);
#endif
}

 void RMXGLRegisterCallbacks(void (*display)(void),void (*reshape)(int,int)){
     #ifdef GLUT
    glutDisplayFunc(display);
    glutReshapeFunc(reshape);
#endif
}
//};