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

enum ShapeType: Int32 { case NULL = 0, CUBE = 1 , PLANE = 2, SPHERE = 3 }

public class RMSGeometry  {
    
    var type: ShapeType
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

    
    init(type: ShapeType = .NULL, parent: RMSParticle! = nil){
        self.parent = parent != nil ? parent.shape : nil
        self.type = type
        self.sizeOfVertex = RMSizeOfVertex(type.rawValue)
        self.sizeOfIndices = RMSizeOfIndices(type.rawValue)
        self.sizeOfIZero = RMSizeOfIZero(type.rawValue)
        //        geometry.verts = RMVertexWrapper.CUBE()
        self.vertices = RMVerticesPtr(type.rawValue)
        self.indices = RMIndicesPtr(type.rawValue)
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

    
    class func CUBE(type: ShapeType = .CUBE, parent: RMSParticle! = nil) -> RMSGeometry! {
        let geometry = RMSGeometry(type: type, parent: parent)
        geometry.type = type
        geometry.sizeOfVertex = RMSizeOfVertex(type.rawValue)
        geometry.sizeOfIndices = RMSizeOfIndices(type.rawValue)
        geometry.sizeOfIZero = RMSizeOfIZero(type.rawValue)
//        geometry.verts = RMVertexWrapper.CUBE()
        geometry.vertices = RMVerticesPtr(type.rawValue)
        geometry.indices = RMIndicesPtr(type.rawValue)
        return geometry
    }
    
    class func SPHERE(parent: RMSParticle! = nil) -> RMSGeometry! {
        
        return self.CUBE(parent: parent)
    }
    
}



