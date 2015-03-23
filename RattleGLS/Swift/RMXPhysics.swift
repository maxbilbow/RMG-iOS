//
//  RMXPhysics.swift
//  RattleGL
//
//  Created by Max Bilbow on 10/03/2015.
//  Copyright (c) 2015 Rattle Media. All rights reserved.
//


public class RMXPhysics {
    var gravity: Float = 0.098
    public var parent: RMSParticle
    //public var world: RMXWorld
    var upVector: RMXVector3
    
    init(parent: RMSParticle!) {
        if parent != nil {
            self.parent = parent
            self.upVector = GLKVector3Make(0,1,0)
        } else {
            fatalError(__FUNCTION__)
        }
    }
    
    class func New(parent: RMSParticle) -> RMXPhysics {
        return RMXPhysics(parent: parent)
    }

    func gVector(hasGravity: Bool) -> RMXVector3 {
        return RMXVector3MultiplyScalar(self.upVector, hasGravity ? Float(-gravity) : 0 )
    }
    
    
    
    func gravityFor(sender: RMSParticle) -> RMXVector3{
        return RMXVector3MultiplyScalar(self.upVector,-sender.body.weight)
    }
    
    
    
    func dragFor(sender: RMSParticle) -> RMXVector3{
        let dragC: Float = sender.body.dragC
        let rho: Float = 0.005 * sender.world!.massDensityAt(sender)
        let u: Float = RMXGetSpeed(sender.body.velocity)
        let area: Float = sender.body.dragArea
        var v: RMXVector3 = RMXVector3Zero()
        RMXVector3SetX(&v, 0.5 * rho * u * u * dragC * area)
        return v
    }
    
    func frictionFor(sender: RMSParticle) -> RMXVector3{
        let µ = sender.world!.µAt(sender)
        return GLKVector3Make(µ, µ, µ);//TODO
    }
    
    func normalFor(sender: RMSParticle) -> RMXVector3 {
        let normal = sender.world!.normalForceAt(sender)
        return RMXVector3MultiplyScalar(self.upVector,normal);
    }
}