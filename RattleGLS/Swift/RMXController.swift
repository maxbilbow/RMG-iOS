//
//  RMXController.swift
//  RattleGL
//
//  Created by Max Bilbow on 23/03/2015.
//  Copyright (c) 2015 Rattle Media. All rights reserved.
//

import Foundation

@objc protocol RMXController {
    
    //var scene: RMXWorld? { get }
    static func New(gvc: GameViewController) -> RMXController
    static func NewWithWorld(world: RMXWorld, gvc: GameViewController) -> RMXController
    var activeCamera: RMXCamera { get }
}