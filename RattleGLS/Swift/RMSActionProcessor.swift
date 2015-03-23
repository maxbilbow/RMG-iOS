//
//  RMSActionProcessor.swift
//  RattleGL
//
//  Created by Max Bilbow on 22/03/2015.
//  Copyright (c) 2015 Rattle Media. All rights reserved.
//

import Foundation


public class RMSActionProcessor {
    let keys: RMSKeys = RMSKeys()
    var activeSprite: RMSParticle {
        return self.world.observer
    }
    var world: RMSWorld
    
    init(world: RMSWorld){
        self.world = world
        RMXLog()
    }
    
    
    func movement(action: String!, speed: Float = 0,  point: [Float]){
        //if (keys.keyStates[keys.forward])  [observer accelerateForward:speed];
        if action == nil { return }
        
        if action == "move" && point.count == 2 {
            self.activeSprite.body.accelerateForward(point[1] * speed)
            self.activeSprite.body.accelerateLeft(point[0] * speed)
        }
        if action == "look" && point.count == 2 {
            self.activeSprite.plusAngle(point[0]*speed, y: point[1]*speed)
        }
        
        if (action == "forward") {
            if speed == 0 {
                self.activeSprite.body.forwardStop()
            }
            else {
                self.activeSprite.body.accelerateForward(speed)
            }
        }
        
        if (action == "back") {
            if speed == 0 {
                self.activeSprite.body.forwardStop()
            }
            else {
                self.activeSprite.body.accelerateForward(-speed)
            }
        }
        if (action == "left") {
            if speed == 0 {
                self.activeSprite.body.leftStop()
            }
            else {
                self.activeSprite.body.accelerateLeft(speed)
            }
        }
        if (action == "right") {
            if speed == 0 {
                self.activeSprite.body.leftStop()
            }
            else {
                self.activeSprite.body.accelerateLeft(-speed)
            }
        }
        
        if (action == "up") {
            if speed == 0 {
                self.activeSprite.body.upStop()
            }
            else {
                self.activeSprite.body.accelerateUp(-speed)
            }
        }
        if (action == "down") {
            if speed == 0 {
                self.activeSprite.body.upStop()
            }
            else {
                self.activeSprite.body.accelerateUp(speed)
            }
        }
        if (action == "jump") {
            if speed == 0 {
                self.activeSprite.actions?.jump()
            }
            else {
                self.activeSprite.actions?.prepareToJump()
            }
        }
        if action == "toggleGravity" && speed == 0{
            self.activeSprite.toggleGravity()
        }
        if action == "universalGravity" && speed == 0 {
            self.world.toggleGravity()
        }
        
        
        
//        else {
//            [RMXGLProxy.activeSprite.mouse setMousePos:x y:y];
        RMXLog("\(self.activeSprite.camera!.viewDescription)\n\(action!) \(speed), \(self.world.activeSprite!.body.position.z)\n")
    }

}