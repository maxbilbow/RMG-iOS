//
//  RMSActionProcessor.swift
//  RattleGL
//
//  Created by Max Bilbow on 22/03/2015.
//  Copyright (c) 2015 Rattle Media. All rights reserved.
//

import Foundation


public class RMSActionProcessor {
    //let keys: RMXController = RMXController()
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
        
        if action == "move" && point.count == 3 {
//            self.activeSprite.body.setVelocity(point, speed: speed)
//            self.activeSprite.body.accelerateLeft(point[0] * speed)
            self.activeSprite.body.accelerateForward(point[2] * speed)
            self.activeSprite.body.accelerateLeft(point[0] * speed)
            self.activeSprite.body.accelerateUp(point[2] * speed)
        }
        if action == "stop" {
            self.activeSprite.body.stop()
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
        if action == "toggleAllGravity" && speed == 0 {
            self.world.toggleGravity()
        }
        if action == "grab" {
            self.activeSprite.actions?.grabItem()
        }
        if action == "throw" {
            
            if self.activeSprite.hasItem {
                RMXLog("Throw: \(self.activeSprite.actions?.item?.name) with speed: \(speed)")
                self.activeSprite.actions?.throwItem(speed)
            } else {
                 self.activeSprite.actions?.grabItem()
                 RMXLog("Grab: \(self.activeSprite.actions?.item?.name) with speed: \(speed)")
            }
            
            
        }
        if action == "enlargeItem" && self.activeSprite.hasItem {
            let size = (self.activeSprite.actions?.item?.body.radius)! * speed
            if size > 0.5 {
                self.activeSprite.actions?.item?.body.radius = size
                self.activeSprite.actions?.item?.body.mass *= size
            }

        }
        
        
        
//        else {
//            [RMXGLProxy.activeSprite.mouse setMousePos:x y:y];
        RMXLog("\(self.activeSprite.camera!.viewDescription)\n\(action!) \(speed), \(self.world.activeSprite!.body.position.z)\n")
    }

}