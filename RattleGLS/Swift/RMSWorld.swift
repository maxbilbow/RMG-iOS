//
//  RMSWorld.swift
//  RattleGL
//
//  Created by Max Bilbow on 10/03/2015.
//  Copyright (c) 2015 Rattle Media. All rights reserved.
//

import Foundation


public class RMSWorld : RMSParticle, RMXWorld {

    private lazy var _action: RMSActionProcessor = RMSActionProcessor(world: self)
    private let GRAVITY: Float = 9.8
    var sprites: [RMSParticle]
    lazy var observer: RMSParticle = RMSParticle(world: self, parent: self).setAsObserver()
    override var physics: RMXPhysics? {
        return self._worldPhysics
    }
    private lazy var _worldPhysics: RMXPhysics? = RMXPhysics(parent: self)
    
    var activeSprite: RMSParticle? {
        return self.observer
    }
    @objc public var activeCamera: RMXCamera? {
        return observer.camera
    }
    
   
    
    init(parent: RMXObject! = nil, name: String = "The World", capacity: Int = 15000) {
        self.sprites = Array<RMSParticle>()
        self.sprites.reserveCapacity(capacity)
        
        super.init(world: nil, parent: parent, name: name)
        self.body.radius = 1000

        
        self.camera = RMXCamera(world: self, pov: observer)
        
        self.sprites.append(self.observer)
        //fatalError("Grav: \(self.physics.gravity)")
         self.isAnimated = false
    }
    
  
    func insertSprite(sprite: RMSParticle){
        if sprite.body.distanceTo(self) <= self.body.radius {
            self.sprites.append(sprite)
        }
    }
            
    func µAt(someBody: RMSParticle) -> Float {
        if (someBody.body.position.y <= someBody.ground  ) {
            return 0.2// * RMXGetSpeed(someBody->body.velocity);//Rolling wheel resistance
        } else {
            return 0.01// * RMXGetSpeed(someBody->body.velocity); //air;
        }
    }
    func massDensityAt(someBody: RMSParticle) -> Float {
        if (someBody.body.position.y < someBody.ground  * 8 / 10 ) {// someBody.ground )
            return 99.1 //water or other
        } else {
            return 0.01 //air;
        }
    }
    func collisionTest(sender: RMSParticle) -> Bool{
    //Have I gone through a barrier?
    if (sender.body.position.y < /*ground - */ sender.ground) {
        //sender->body.position.y = sender.ground;
        //sender->body.velocity.y = 0;
        return true
    } else { return false }
    
    //Then restore
    }
    
    func normalForceAt(someBody: RMSParticle) -> Float {
        var result: Float = 0
        let bounce: Float = 1
        var s: String = ""
        if someBody.body.position.y < someBody.ground  * 9 / 10 {
            result = someBody.body.weight + Float(abs(-someBody.body.position.y / someBody.ground)) * bounce
            s = "\(someBody.body.position.y ) Bouncing   || "
        } else if someBody.body.position.y  <= someBody.ground  {
            s = "\(someBody.body.position.y ) == Ground  || "
            result = someBody.body.weight
            RMXVector3SetY(&someBody.body.position, someBody.ground - someBody.upThrust)
        } else if someBody.body.position.y  > someBody.ground {
            result = 0//someBody.weight// * self.physics.gravity; //air;
            s = "\(someBody.body.position.y) IN THE AIR || "
        } else {
            s = "\(someBody.body.position.y) DEFAULT    || "
            result = someBody.body.weight
        }
//        if someBody is RMXObserver {
//            println ("\(s)Normal: \(result), Weight: \(someBody.weight), Altitude: \(someBody.altitude), upThrust: \(someBody.upThrust), Ground: \(someBody.ground), Radius: \(someBody.body.radius), dF: \(someBody.downForce)")
//        }
        return result
    }
    
   
    override public func animate() {
        super.animate()
        for sprite in sprites {
            sprite.animate()
           
        }
        self.debug()
        if self.physics == nil {
            fatalError("World Physics is nil")
        }
        
    }
    
    override func reset() {
        self.observer.reset()
        //super.reset()
    }
    
    func closestObjectTo(sender: RMSParticle)->RMSParticle? {
        var closest: RMSParticle = sprites[1]
        var dista: Float = sender.body.distanceTo(closest)
        for sprite in sprites {
            let distb: Float = sender.body.distanceTo(sprite)
            //NSString *lt = @" < ";
            if sprite.rmxID != sender.rmxID {
                if distb < dista {
                    closest = sprite
                    dista = distb
                }
            }
        }
        if dista < sender.actions!.reach + closest.body.radius + sender.body.radius {
            return closest
        }
        return nil
    }
    
  
    //private var _hasGravity = false
    override public func toggleGravity() {
        for sprite in sprites {
            if !(sprite.isLightSource) {
                sprite.setHasGravity(self.hasGravity)
            }
        }
        super.toggleGravity()
    }
   /*
    @objc public func message(function: String, args: [AnyObject]?) {
        switch function {
        case "toggleGravity":
            self.toggleGravity()
            break
        case "resetWorld":
            self.reset()
            break
        default:
            println("\(function): Not Recognised")
        }
        print(function)
        if args != nil {
            for arg in args! {
                print(" \(arg)")
            }
        }
        println()
        
    }*/
//    @objc public func doAction(speed: Float, action: String){
//        self.action(speed: speed, action: action)
//    }
//    @objc public func doAction(speed: Float, action: String , point: [Float]){
//        self.action(speed: speed, action: action, point: point)
//    }
    
    func action(action: String = "reset",speed: Float = 0, point: [Float] = []) {
        self._action.movement( action,speed: speed, point: point)
    }
    
   
    
}