//
//  GameViewController.swift
//  RattleGLES
//
//  Created by Max Bilbow on 23/03/2015.
//  Copyright (c) 2015 Rattle Media Ltd. All rights reserved.
//

class GameViewController : RMOViewController {
    lazy var dPad: RMXDPad = RMXDPad.New(self)
    
    override func getGeometry(shape: AnyObject?) -> RMOGeometry! {
        super.getGeometry(shape)
        return shape is RMSParticle ? (shape as! RMSParticle).geometry : nil
    }
    
    override var shapes: NSMutableArray {
        return self.dPad.world.shapes
    }
    var camera: RMXCamera {
        return self.dPad.activeCamera
    }
    override func viewDidLoad() {
        self.viewMatrix = self.dPad.activeCamera.modelViewMatrix
        super.viewDidLoad()
    }
    
    override func update(){
        self.dPad.animate()
        self.projectionMatrix = self.camera.getProjectionMatrix(Float(self.view.bounds.size.width), height: Float(self.view.bounds.size.height))
        self.viewMatrix = self.dPad.activeCamera.modelViewMatrix
        self.rotation += Float(self.timeSinceLastUpdate * 0.5)
        super.update()
    }
}
