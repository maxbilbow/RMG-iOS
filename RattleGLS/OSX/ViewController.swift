//
//  ViewController.swift
//  Rattle Physics Beta
//
//  Created by Max Bilbow on 18/03/2015.
//  Copyright (c) 2015 Rattle Media. All rights reserved.
//

import Cocoa
import SceneKit

public class ViewController: NSViewController {
    
//    @IBOutlet weak var glView: RMSView! = RMSView()
    
   
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    
    }

    override public var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    
    @IBAction func launchGame(sender: AnyObject?) {
        //glView = RMSView()
//        self.scene = self.initGame()
//        self.glView.camera = self.camera
//        self.glView.setupGL()
        self.view = RMSView(frame: NSRect(), pixelFormat: NSOpenGLPixelFormat())
        return
    }
    
    
    private func initGame() -> RMXWorld? {
        let scene = RMXArt.initializeTestingEnvironment()
        autoreleasepool {
            
            for sprite in scene.sprites {
                if sprite.rmxID != scene.observer?.rmxID {
                    
                    if sprite.isAnimated {
                        sprite.addBehaviour({
                            let dist = sprite.body.distanceTo(scene.observer!)
                            let distTest = sprite.body.radius + (scene.observer?.body.radius)! + (scene.observer?.actions?.reach)!
                            if dist <= distTest {
                                sprite.body.velocity = RMXVector3Add(sprite.body.velocity, (scene.observer?.body.velocity)!)
                            } else if dist < distTest * 10 {
                                sprite.actions?.prepareToJump()
                            }
                        })
                        
                        sprite.addBehaviour({
                            if !sprite.hasGravity && scene.observer?.actions!.item != nil {
                                if sprite.body.distanceTo((scene.observer?.actions?.item)!) < 50 {
                                    sprite.hasGravity = true
                                }
                            }
                        })
                        
                        
                    }
                }
            }
           
        }
        return scene
    }
}

