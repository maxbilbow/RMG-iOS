//
//  CWrappers.h
//  RattleGLES
//
//  Created by Max Bilbow on 24/03/2015.
//  Copyright (c) 2015 Rattle Media Ltd. All rights reserved.
//

#ifndef RattleGLES_CWrappers_h
#define RattleGLES_CWrappers_h

#import <GLKit/GLKit.h>
#endif
extern int RMSizeOfVert();
extern const void * RMOffsetVertCol();
extern const void * RMOffsetVertTex();
extern const void * RMOffsetVertNorm();
extern const void * RMOffsetVertPos();
extern NSString * RMOPathForResource(NSString* path, NSString* ofType);
extern int RMSizeOf(void * ptr);
extern int RMSizeOfAt(void * ptr, int i);


