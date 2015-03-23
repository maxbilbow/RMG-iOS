//
//  RMXDPad.swift
//  RattleGL
//
//  Created by Max Bilbow on 23/03/2015.
//  Copyright (c) 2015 Rattle Media. All rights reserved.
//

import Foundation
import CoreMotion
import UIKit

func RMXLog(message: String,sender: String = __FUNCTION__) {
    println("\(sender) \(message)")
}

@objc public class RMXDPad : CMMotionManager, RMXController {
    var hRotation:Float = 0.0   //Horizontal angle
    var vRotation:Float = 0.0   //Vertical rotation angle of the camera
    var cameraMovementSpeed:Float = 0.02
    var dataIn: String = "No Data"
    var gvc: GameViewController
    var world: RMSWorld
    var leftPanData: CGPoint = CGPoint(x: 0,y: 0)
    var rightPanData: CGPoint = CGPoint(x: 0,y: 0)
    var hasMotion = false
    
    var activeCamera: RMXCamera {
        return self.world.activeCamera!
    }
    
    required public init(gvc: GameViewController, world: RMXWorld){
        
        self.gvc = gvc
        self.world = world as! RMSWorld
        super.init()
        
        if hasMotion {
            self.startAccelerometerUpdates()
            self.startDeviceMotionUpdates()
            self.startGyroUpdates()
            self.startMagnetometerUpdates()
        }
        self.viewDidLoad()
    }
    
    static func New(gvc: GameViewController) -> RMXController {
        return RMXDPad(gvc: gvc, world: RMXArt.initializeTestingEnvironment())
    }
    
    static func NewWithWorld(world: RMXWorld, gvc: GameViewController) -> RMXController {
        return RMXDPad(gvc: gvc, world: world)
    }
    
    func interpretAccelerometerDataFor(particle: NSObject) {/*
        if (particle.effectedByAccelerometer) {
        var vector: [Float] = [ 0, 0, 0];
        if self.deviceMotion != nil {
        //particle.physics.description
        vector = [ -Float(self.accelerometerData!.acceleration.x),
        -Float(self.accelerometerData!.acceleration.y),
        -Float(self.accelerometerData!.acceleration.z)]
        //TODO: set to particle
        //particle.body.orientation =
        particle.accelerateForward(vector[0])
        particle.accelerateLeft(vector[1])
        
        NSLog("--- Accelerometer Data")
        NSLog("Motion: x\(self.deviceMotion!.userAcceleration.x.toData()), y\(self.deviceMotion!.userAcceleration.y.toData()), z\(self.deviceMotion!.userAcceleration.z.toData())")
        }
        if self.accelerometerData? != nil {
        let dp = "04.1"
        NSLog("Acceleration: x\(self.accelerometerData!.acceleration.x.toData()), y\(self.accelerometerData!.acceleration.y.toData()), z\(self.accelerometerData!.acceleration.z.toData())")
        NSLog("=> upVector: x\(vector[0].toData(dp: dp)), y\(vector[1].toData(dp: dp)), z\(vector[2].toData(dp: dp))")
        }
        //NSLog(particle.describePosition())
        } */
    }
    
    func log(message: String,sender: String = __FUNCTION__) {
        self.dataIn += "  \(sender): \(message)"
    }
    
    func interpretAccelerometerData(){
        if !hasMotion { return }
        self.i++
        if self.i == 1 { self.i=0 } else { return }
        if deviceMotion != nil {
            var x,y,z, q, r, s, t, u, v,a,b,c,e,f,g,h,i,j,k,l,m:Double
            x = self.deviceMotion.gravity.x
            y = self.deviceMotion.gravity.y
            z = self.deviceMotion.gravity.z
            q = self.deviceMotion.magneticField.field.x
            r = self.deviceMotion.magneticField.field.y
            s = self.deviceMotion.magneticField.field.z
            t = self.deviceMotion.rotationRate.x
            u = self.deviceMotion.rotationRate.y
            v = self.deviceMotion.rotationRate.z
            a = self.deviceMotion.attitude.pitch
            b = self.deviceMotion.attitude.roll
            c = self.deviceMotion.attitude.yaw
            e = self.gyroData.rotationRate.x
            f = self.gyroData.rotationRate.y
            g = self.gyroData.rotationRate.z
            if self.magnetometerData != nil {
                h = self.magnetometerData.magneticField.x
                i = self.magnetometerData.magneticField.y
                j = self.magnetometerData.magneticField.z
            } else { h=0;i=0;j=0 }
            k = self.deviceMotion.userAcceleration.x
            l = self.deviceMotion.userAcceleration.y
            m = self.deviceMotion.userAcceleration.z
            
            let d = self.deviceMotion.magneticField.accuracy.value
            
            println("           Gravity,\(x.toData()),\(y.toData()),\(z.toData())")
            println("   Magnetic Field1,\(q.toData()),\(r.toData()),\(s.toData())")
            println("   Magnetic Field2,\(h.toData()),\(i.toData()),\(j.toData())")
            println("     Rotation Rate,\(t.toData()),\(u.toData()),\(v.toData())")
            println("Gyro Rotation Rate,\(e.toData()),\(f.toData()),\(g.toData())")
            println("          Attitude,\(a.toData()),\(b.toData()),\(c.toData())")
            println("          userAcc1,\(k.toData()),\(l.toData()),\(m.toData())")
            
            
            if self.accelerometerData != nil {
                let dp = "04.1"
                println("          userAcc2,\(self.accelerometerData!.acceleration.x.toData()),\(self.accelerometerData!.acceleration.y.toData()),\(self.accelerometerData!.acceleration.z.toData())")
                // println("      Magnetic field accuracy: \(d)")
            }
        }
        else {
            //log("No motion?!")
        }
        // println()
    }
    
    func viewDidLoad(){
        let w = gvc.view.bounds.size.width
        let h = gvc.view.bounds.size.height
        
        let leftView: UIView = UIImageView(frame: CGRectMake(0, 0, w/2, h))
        let lPan:UIPanGestureRecognizer = UIPanGestureRecognizer(target: self,action: "handlePanLeftSide:")
        leftView.addGestureRecognizer(lPan)
        leftView.userInteractionEnabled = true
        gvc.view.addSubview(leftView)
        
        let rightView: UIView = UIImageView(frame: CGRectMake(w/2, 0, w/2, h))
        let rPan:UIPanGestureRecognizer = UIPanGestureRecognizer(target: self,action: "handlePanRightSide:")
        rightView.addGestureRecognizer(rPan)
        rightView.userInteractionEnabled = true
        gvc.view.addSubview(rightView)
        
        
        let dt: UITapGestureRecognizer = UITapGestureRecognizer(target: self,  action: "handleDoubleTap:")
        dt.numberOfTapsRequired = 2
        gvc.view.addGestureRecognizer(dt)
        
        let lp: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self,  action: "longPressGestureRecognizer:")
//        lp.minimumPressDuration = 
        gvc.view.addGestureRecognizer(lp)
        
        let tt: UITapGestureRecognizer = UITapGestureRecognizer(target: self,  action: "handleTripleTap:")
        tt.numberOfTapsRequired = 3
        gvc.view.addGestureRecognizer(tt)
        
    }
    var i: Int = 0
    func update() {
        self.interpretAccelerometerData()
        if dataIn != ""{
            println("\(dataIn)")
            self.log("\n x\(leftPanData.x.toData()), y\(leftPanData.y)",sender: "LEFT")
            self.log("x\(rightPanData.x.toData()), y\(rightPanData.y.toData())",sender: "RIGHT")
        }
        dataIn = ""
    }
    
    func handleDoubleTap(recognizer: UITapGestureRecognizer) {
        RMXLog("Double Tap")
        self.world.action(action: "toggleGravity")
    }
    
    func handleTripleTap(recognizer: UITapGestureRecognizer) {
        RMXLog("Triple Tap")
        self.world.reset()
    }
    
    func longPressGestureRecognizer(recognizer: UILongPressGestureRecognizer){
        self.world.action(action: "jump", speed: 1)
    }
    
    
    //The event Le method
    func handlePanLeftSide(recognizer: UIPanGestureRecognizer) {
        let point = recognizer.velocityInView(gvc.view);
        let speed:Float = -0.001
        self.world.action(action: "move", speed: speed, point: [Float(point.x), Float(point.y)])
    }
    
    
    //The event handling method
    func handlePanRightSide(recognizer: UIPanGestureRecognizer) {
        let point = recognizer.velocityInView(gvc.view);
        let speed:Float = 1
        self.world.action(action: "look", speed: speed, point: [Float(point.x), Float(point.y)])
    }
    
    
    func animate(){
        self.world.animate()
    }
}
