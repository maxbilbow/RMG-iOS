//
//  RMXWorld.swift
//  RattleGL
//
//  Created by Max Bilbow on 23/03/2015.
//  Copyright (c) 2015 Rattle Media. All rights reserved.
//

import Foundation

@objc public protocol RMXWorld  {
    //    var effect: GLKBaseEffect? { get set }
    //    var context: GLContext? { get set }
    var activeCamera: RMXCamera? { get }
//    var activeSprite: RMXParticle? { get }
//    func animate()
//    func message(function: String, args: [AnyObject]?)
//    func reset()
//    func doAction(speed: Float, action: String, point: [Float])
//    func doAction(speed: Float, action: String)
}
