//
//  RMXInterface.swift
//  RattleGLES
//
//  Created by Max Bilbow on 25/03/2015.
//  Copyright (c) 2015 Rattle Media Ltd. All rights reserved.
//

import Foundation



class RMXInterface : NSObject {
    var debugData: String = "No Data"
    var gvc: GameViewController
    var world: RMSWorld
    var controllers: [ String : ( isActive: Bool, process: ()->() ) ]
    
    var activeCamera: RMXCamera {
        return self.world.activeCamera!
    }
    
    init(gvc: GameViewController, world: RMSWorld){
        self.gvc = gvc
        self.world = world
        self.controllers = [ "keyboard" : ( isActive: RMX.isDebugging,
            process: {
                RMXLog("motion not used in iOS")
        } ) ]
        super.init()
        self.world.clock = RMXClock(world: world, interface: self)
        self.viewDidLoad()
    }
    
    func viewDidLoad(){
        self.setUpGestureRecognisers()
    }

    func setUpGestureRecognisers() {
        
    }
    
    func setController(forKey key: String, run process: ()->() ) -> ( isActive: Bool, process: ()->() )? {
        let old = self.controllers.updateValue((isActive: false, process: process ), forKey: key)
        if old != nil {
           self.controllers[key]!.isActive = old!.isActive
        }
        return self.controllers[key]
    }

    func getController(forKey key: String) -> ( isActive: Bool, process: ()->() )? {
        return self.controllers[key]
    }

    func processControllers(){
        for controller in self.controllers {
            if controller.1.isActive {
                controller.1.process()
            }
        }
    }

    func debug() {
        if debugData != ""{
            RMXLog("\(debugData)")
//            self.log("\n x\(leftPanData.x.toData()), y\(leftPanData.y)",sender: "LEFT")
//            self.log("x\(rightPanData.x.toData()), y\(rightPanData.y.toData())",sender: "RIGHT")
        }
        debugData = ""
    }
    
        
    func animate(){
        self.processControllers()
        self.world.animate()
        if RMX.isDebugging {
            self.debug()
        }
    }


}