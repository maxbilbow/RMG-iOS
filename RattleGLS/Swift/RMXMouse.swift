//
//  RMXMouse.swift
//  RattleGL
//
//  Created by Max Bilbow on 15/03/2015.
//  Copyright (c) 2015 Rattle Media. All rights reserved.
//

import Foundation


@objc public class RMXMouse : RMXObject{
    
    var hasFocus = false
    var dx: Int32 = 0
    var dy: Int32 = 0
    var pos:(x:Int32, y:Int32) = ( x:0, y: 0 )

    var x: Int32 {
        return self.pos.x
    }
    
    var y: Int32 {
        return self.pos.y
    }
    func toggleFocus()    {
        self.hasFocus = !self.hasFocus
    }
    
    
    
    override var position: RMXVector3 {
        return GLKVector3Make(Float(pos.x), Float(pos.y), 0)
    }
    
    func centerView(center: CFunctionPointer<(Int32, Int32)->Void>) {
        //RMXGLCenter(center,self.pos.x,self.pos.y)
    }
    
    func setMousePos(x: Int32, y:Int32) {
        self.pos.x = x// + dx;
        self.pos.y = y//;
    }
    
    func mouse2view(x:Int32, y:Int32) {
    //dx = dy = 0;
    
    
        var DeltaX: Int32 = 0; var DeltaY: Int32 = 0
    
    //RMXCGGetLastMouseDelta(&DeltaX, &DeltaY)
    

        var dir:Int32 = self.hasFocus ? 1 : -1
    
        var theta: Float = Float(DeltaX * Int32(dir))
        var phi: Float =   Float(DeltaY * Int32(dir))// / 20.0f;
    
        self.parent!.plusAngle(theta, y:phi)
    
    }
    
    func calibrateView(x: Int32, y:Int32)    {
//        RMXCGGetLastMouseDelta(&self.dx, &self.dy)
    }
    
}