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
import GLKit

public class RMXDPad : CMMotionManager {
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
    
    init(gvc: GameViewController, world: RMSWorld){
        
        self.gvc = gvc
        self.world = world //as! RMSWorld
        super.init()
        
        if hasMotion {
            self.startAccelerometerUpdates()
            self.startDeviceMotionUpdates()
            self.startGyroUpdates()
            self.startMagnetometerUpdates()
        }
        self.viewDidLoad()
    }
    
    static func New(gvc: GameViewController) -> RMXDPad {
        return RMXDPad(gvc: gvc, world: RMXArt.initializeTestingEnvironment())
    }
    
    static func NewWithWorld(world: RMSWorld, gvc: GameViewController) -> RMXDPad {
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
    private let _testing = false
    func interpretAccelerometerData(){
        if !hasMotion { return }
        else {
            let g = self.deviceMotion.gravity
            self.world.physics.upVector = GLKVector3Make(-Float(g.x), -Float(g.y), -Float(g.z))
        }
        if !_testing { return }
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
        let rightView: UIView = UIImageView(frame: CGRectMake(w/2, 0, w/2, h))
        
        func setLeftView() {
            
            let lPan:UIPanGestureRecognizer = UIPanGestureRecognizer(target: self,action: "handlePanLeftSide:")
            leftView.addGestureRecognizer(lPan)
            
            let tapLeft: UITapGestureRecognizer = UITapGestureRecognizer(target: self,  action: "handleTapLeft:")
            leftView.addGestureRecognizer(tapLeft)
            
            
            
            leftView.userInteractionEnabled = true
            
            self.gvc.view.addSubview(leftView)
        }
        
        func setRightView() {
        
            
            let rPan:UIPanGestureRecognizer = UIPanGestureRecognizer(target: self,action: "handlePanRightSide:")
            rightView.addGestureRecognizer(rPan)
            
            let tapRight: UITapGestureRecognizer = UITapGestureRecognizer(target: self,  action: "handleTapRight:")
            rightView.addGestureRecognizer(tapRight)
            
            
            rightView.userInteractionEnabled = true
            self.gvc.view.addSubview(rightView)
        
        }
        
        
        
        func setForBothViews(){
            
            let twoFingerTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,  action: "handleDoubleTouchTap:")
            twoFingerTap.numberOfTouchesRequired = 2
            twoFingerTap.numberOfTapsRequired = 1
            self.gvc.view.addGestureRecognizer(twoFingerTap)
            
            let lp: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self,  action: "longPressGestureRecognizer:")
            //        lp.minimumPressDuration =
            self.gvc.view.addGestureRecognizer(lp)
            
        }
        
        setLeftView(); setRightView(); setForBothViews()
       
        func misc() {
        
            let tt: UITapGestureRecognizer = UITapGestureRecognizer(target: self,  action: "handleTripleTap:")
            tt.numberOfTapsRequired = 3
            rightView.addGestureRecognizer(tt)

            let twoFingers: UITapGestureRecognizer = UITapGestureRecognizer(target: self,  action: "handleDoubleTouch:")
            twoFingers.numberOfTouchesRequired = 2
            self.gvc.view.addGestureRecognizer(twoFingers)
            
            
            
            let swipeUp: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self,  action: "handleSwipeUp:")
            swipeUp.numberOfTouchesRequired = 1
            swipeUp.direction = UISwipeGestureRecognizerDirection.Up
            self.gvc.view.addGestureRecognizer(swipeUp)
            
            let swipeDown: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self,  action: "handleSwipeDown:")
            swipeDown.numberOfTouchesRequired = 1
            swipeDown.direction = UISwipeGestureRecognizerDirection.Down
            self.gvc.view.addGestureRecognizer(swipeDown)
            
            let swipeLeft: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self,  action: "handleSwipeLeft:")
            swipeLeft.numberOfTouchesRequired = 1
            swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
            self.gvc.view.addGestureRecognizer(swipeLeft)
            
            let swipeRight: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self,  action: "handleSwipeRight:")
            swipeRight.numberOfTouchesRequired = 1
            swipeRight.direction = UISwipeGestureRecognizerDirection.Right
            self.gvc.view.addGestureRecognizer(swipeRight)
            
            let swipeDownTwo: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self,  action: "handleSwipeDownTwo:")
            swipeDownTwo.numberOfTouchesRequired = 2
            swipeDownTwo.direction = UISwipeGestureRecognizerDirection.Down
            self.gvc.view.addGestureRecognizer(swipeDownTwo)
        }
        

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
    
    func handleTapLeft(recognizer: UITapGestureRecognizer) {
        RMXLog("Left Tap")
        self.world.action(action: "grab")
    }
    
    func handleTapRight(recognizer: UITapGestureRecognizer) {
        RMXLog("Right Tap")
        self.world.action(action: "throw", speed: 10)
    }
    
    func handleDoubleTouch(recognizer: UITapGestureRecognizer) {
        RMXLog("Double Touch")
//        self.world.action(action: "toggleAllGravity")
    }

    func handleDoubleTouchTap(recognizer: UITapGestureRecognizer) {
        self.world.action(action: "toggleGravity")
        
    }

    func handleTripleTap(recognizer: UITapGestureRecognizer) {
        RMXLog("Triple Tap")
        self.world.reset()
    }
    
    func longPressGestureRecognizer(recognizer: UILongPressGestureRecognizer){
        self.world.action(action: "toggleAllGravity")
    }
    
    
    //The event Le method
    func handlePanLeftSide(recognizer: UIPanGestureRecognizer) {
        let point = recognizer.velocityInView(gvc.view); let speed:Float = -0.005

        if recognizer.state == UIGestureRecognizerState.Ended {
            self.world.action(action: "stop")
        } else {
            self.world.action(action: "move", speed: speed, point: [Float(point.x),0, Float(point.y)])
        }
        
        
    }
    
    
    //The event handling method
    func handlePanRightSide(recognizer: UIPanGestureRecognizer) {
        let point = recognizer.velocityInView(gvc.view);
        let speed:Float = 1
        self.world.action(action: "look", speed: speed, point: [Float(point.x), Float(point.y)])
    }
    
    func handlePanDownTwo(recognizer: UIPanGestureRecognizer) {
        if recognizer.state == UIGestureRecognizerState.Ended {
            self.world.action(action: "jump")
        } else {
            self.world.action(action: "jump", speed: 1)
        }
    }
    

    func handleSwipeUp(recognizer: UISwipeGestureRecognizer) {
        self.world.action(action: "forward", speed: 1)
    }
    func handleSwipeDown(recognizer: UISwipeGestureRecognizer) {
        self.world.action(action: "back", speed: 1)
    }
    func handleSwipeLeft(recognizer: UISwipeGestureRecognizer) {
        self.world.action(action: "left", speed: 1)
    }
    func handleSwipeRight(recognizer: UISwipeGestureRecognizer) {
        self.world.action(action: "right", speed: 1)
    }
    
    func animate(){
        self.interpretAccelerometerData()
        self.world.animate()
    }
}
