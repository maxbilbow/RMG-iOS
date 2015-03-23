//
//  main.swift
//  RattleGLS
//
//  Created by Max Bilbow on 11/03/2015.
//  Copyright (c) 2015 Rattle Media. All rights reserved.
//

import Foundation
//let rmxDebugger = RMXDebugger()

//@objc public class world {
//    static let thisWorld: RMXWorld = RMXArt.initializeTestingEnvironment()
//    static var observer: RMXParticle {
//        return thisWorld.observer!
//    }
//}


//@NSApplicationMain
public class RMXGLContext : NSOpenGLContext {
    
    var world: RMXWorld?
    var activeCamera: RMXCamera? {
        return world?.activeCamera
    }
    
//    public func update(){
//        self.world?.animate()
//    }
    
    public func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        //start()
        
    }
    
    public func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    public func buildScene() -> RMXWorld{
        let world: RMXWorld = RMXArt.initializeTestingEnvironment()
        RMXLog("BUILDING")
        autoreleasepool {
            for sprite in world.sprites {
                if sprite.rmxID != world.observer.rmxID {
                    
                    // animate the 3d object
                    
                    //ship.runAction(SCNAction.repeatActionForever(SCNAction.rotateByX(0, y: 2, z: 0, duration: 1000)))
                    if sprite.isAnimated {
//                        sprite.shape!.node = self.rootNode.childNodeWithName("ship1", recursively: true)!
//                        sprite.body.position = RMXVector3Zero()
//                        sprite.shape?.draw()
                        sprite.addBehaviour({
                            let dist = sprite.body.distanceTo(world.observer)
                            let distTest = sprite.body.radius + world.observer.body.radius + world.observer.actions!.reach
                                if dist <= distTest / 2 {
                                    sprite.body.velocity = RMXVector3Add(sprite.body.velocity, world.observer.body.velocity)
                                } else if dist < distTest * 10 {
                                    sprite.actions?.prepareToJump()
                                }
                        })
                        
                        sprite.addBehaviour({
                            if !sprite.hasGravity && world.observer.actions!.item != nil {
                                if sprite.body.distanceTo((world.observer.actions?.item)!) < 50 {
                                    sprite.hasGravity = true
                                }
                            }
                        })
                    }
                }
                
                
            }
            if RMX.usingDepreciated {
                RMXGLProxy.initialize(world,callbacks: RepeatedKeys)
                RMXRun(Process.argc, Process.unsafeArgv)
            } else {
                RMXLog("Init without depreciated methods")
            }
        }
        self.world = world
        return world
    }
    public override func update() {
        super.update()
        RMXLog()
    }
    
}

//Main().start()
