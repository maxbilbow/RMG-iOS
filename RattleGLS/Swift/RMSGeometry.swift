//
//  RMSGeometry.swift
//  RattleGL
//
//  Created by Max Bilbow on 23/03/2015.
//  Copyright (c) 2015 Rattle Media. All rights reserved.
//

import Foundation

public struct RMSVertex {
    var Position: [Float]
    var Color: [Float]
    var TexCoord: [Float]
    var Normal: [Float]
}

public struct RMSPosition {
    var x, y, z: Int
}

extension RMOGeometry {
    class func CUBE(parent: RMSParticle) -> RMOGeometry! {
        let cube = self.RMO_CUBE(parent.shape)
        return cube
    }
    
    class func PLANE(parent: RMSParticle) -> RMOGeometry! {
        let shape = self.RMO_PLANE(parent.shape)
        return shape
    }
    
    class func SPHERE(parent: RMSParticle) -> RMOGeometry! {
        let shape = self.RMO_CUBE(parent.shape)
        return shape
    }
    
}



