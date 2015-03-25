//
//  RMSGeometry.swift
//  RattleGL
//
//  Created by Max Bilbow on 23/03/2015.
//  Copyright (c) 2015 Rattle Media. All rights reserved.
//

import Foundation
import GLKit

public struct RMSVertex {
    var Position: [Float]
    var Color: [Float]
    var TexCoord: [Float]
    var Normal: [Float]
}

public struct RMSPosition {
    var x, y, z: Int
}
/*

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
*/
 class RMSGeometry  {
    
//    var verts: RMVertexWrapper! = nil
    var vertices: UnsafePointer<Void>!=nil
    var indices: UnsafePointer<Void>!=nil
   var sizeOfVertex: GLsizeiptr! = nil// {
//        return GLintptr(self.verts.sizeV)
//    }
    var sizeOfIndices: GLintptr! = nil //{
//        return GLintptr(self.verts.sizeI)
//    }
    var sizeOfIZero: GLsizei! = nil
    private var parent: RMXShape! = nil

    
    init(parent: RMSParticle! = nil){
        self.parent = parent != nil ? parent.shape : nil
    }
    
    var translationMatrix: RMXMatrix4 {
        return self.parent.translationMatrix
    }
    
    var rotationMatrix: RMXMatrix4 {
        return self.parent.rotationMatrix
    }
    
    var scaleMatrix: RMXMatrix4 {
        return self.parent.scaleMatrix;
    }

    
    class func CUBE(parent: RMSParticle! = nil) -> RMSGeometry! {
        let geometry = RMSGeometry(parent: parent)
//        geometry.parent = parent.shape
        geometry.sizeOfVertex = RMSizeOfVertexCube()
        geometry.sizeOfIndices = RMSizeOfIndicesCube()
        geometry.sizeOfIZero = RMSizeOfIZeroCube()
//        geometry.verts = RMVertexWrapper.CUBE()
        geometry.vertices = RMVerticesCubePtr()
        geometry.indices = RMIndicesCubePtr()
        return geometry
    }
    
    class func PLANE(parent: RMSParticle!) -> RMSGeometry! {
        
        return self.CUBE(parent: parent)
    }
    
    class func SPHERE(parent: RMSParticle!) -> RMSGeometry! {
        
        return self.CUBE(parent: parent)
    }
    
}



