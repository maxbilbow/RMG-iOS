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

class RMXDPad : RMXInterface {
    
    private let _testing = false
    private let _hasMotion = false
    
    let motionManager: CMMotionManager = CMMotionManager()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        if _hasMotion {
            self.motionManager.startAccelerometerUpdates()
            self.motionManager.startDeviceMotionUpdates()
            self.motionManager.startGyroUpdates()
            self.motionManager.startMagnetometerUpdates()
        }

        self.controllers["accelorometer"] = ( _hasMotion , self.accelerometer )
        

    }
    override func update() {
        super.update()
    }
    
    
    override func setUpGestureRecognisers(){
        let w = self.gvc.view.bounds.size.width
        let h = self.gvc.view.bounds.size.height
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
            
            let tap: UIGestureRecognizer = UIGestureRecognizer(target: self,  action: "noTouches:")
            self.view.addGestureRecognizer(tap)
            
//            let twoPan:UIPanGestureRecognizer = UIPanGestureRecognizer(target: self,action: "handlePanDownTwo:")
//            rightView.addGestureRecognizer(twoPan)
//            rightView.addGestureRecognizer(twoPan)
            
            self.gvc.view.addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: "handlePinch:"))
            
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
    
    var i = 0
    
}


