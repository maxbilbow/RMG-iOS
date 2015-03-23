//
//  RMSPhysicsBody.swift
//  RattleGL
//
//  Created by Max Bilbow on 10/03/2015.
//  Copyright (c) 2015 Rattle Media. All rights reserved.
//



@objc public class RMSPhysicsBody {
    
    private let PI: Float = 3.14159265358979323846
    var position, velocity, acceleration, forces: RMXVector3
    var orientation: RMXMatrix3
    var vMatrix: RMXMatrix4
    var parent: RMSParticle
    var accelerationRate:Float = 0
    var rotationSpeed:Float = 0
    var hasFriction = true
    var hasGravity = false
    
    var world: RMSWorld {
        return self.parent.world!
    }

    var theta, phi, radius, mass, dragC: Float
    var dragArea: Float {
        return ( self.radius * self.radius * self.PI )
    }
    
    init(parent: RMSParticle, mass: Float = 1, radius: Float = 1, dragC: Float = 0.1,
        accRate: Float = 0.4, rotSpeed:Float = 0.01){
        self.theta = 0
        self.phi = 0
        self.mass = mass
        self.radius = radius
        self.dragC = dragC
        self.position = GLKVector3Make(0,0,0)
        self.velocity = GLKVector3Make(0,0,0)
        self.acceleration = GLKVector3Make(0,0,0)
        self.forces = GLKVector3Make(0,0,0)
        self.orientation = GLKMatrix3Identity
        self.vMatrix = GLKMatrix4MakeScale(0,0,0)
        self.accelerationRate = accRate
        self.rotationSpeed = rotSpeed
        self.parent = parent
    }
    
    class func New(parent: RMSParticle) -> RMSPhysicsBody{
        return RMSPhysicsBody(parent: parent)
    }
    class func New(parent: RMSParticle, mass: Float = 1, radius: Float = 1, dragC: Float = 0.1) -> RMSPhysicsBody {
        return RMSPhysicsBody(parent: parent, mass: mass, radius: radius, dragC: dragC)
    }
    
    var weight: Float{
        return self.mass * parent.physics!.gravity
    }
    
    func accelerateForward(v: Float) {
        
        RMXVector3SetZ(&self.acceleration, v * self.accelerationRate)
    }
    
    func accelerateUp(v: Float) {
        RMXVector3SetY(&self.acceleration, v * self.accelerationRate)
    }
    
    func accelerateLeft(v: Float) {
        RMXVector3SetX(&self.acceleration, v * self.accelerationRate)
    }
    
    
    func forwardStop() {
        RMXVector3SetZ(&self.acceleration,0)
    }
    
    func upStop() {
        RMXVector3SetY(&self.acceleration,0)
    }
    
    func leftStop() {
        RMXVector3SetX(&self.acceleration,0)
    }
    
    func plusAngle(x:Float, y:Float, z: Float = 0) {
        //body.position.z += theta; return;
        let theta = x * self.rotationSpeed * PI_OVER_180
        let phi = y * -self.rotationSpeed * PI_OVER_180
        
        
        //let lim = CGFloat(cos(0.0))
        //        if self.body.phi + phi < lim && self.body.phi + phi > -lim {
        //            self.body.phi += phi
        //            self.body.angles.phi = -lim;
        //        }
        
        self.theta += theta
        
        
        
        
        self.orientation = GLKMatrix3Rotate(self.orientation, theta, 0, 1, 0);
        self.orientation = GLKMatrix3RotateWithVector3(self.orientation, phi, self.leftVector)
        RMXLog("\n   Left: \(self.leftVector.print)\n     Up: \(self.upVector.print)\n    FWD: \(self.forwardVector.print)")
        
    }
    
    func animate()    {
        //GLKVector3 upThrust = GLKVector3Make( 0,0,0 );
        let g = self.hasGravity ? self.parent.physics!.gravityFor(self.parent) : RMXVector3Zero()
        let n = (self.hasGravity) ? self.parent.physics!.normalFor(self.parent) : RMXVector3Zero()
        let f = self.parent.physics!.frictionFor(self.parent)// : GLKVector3Make(1,1,1);
        let d = self.parent.physics!.dragFor(self.parent)// : GLKVector3Make(1,1,1);
        
        
        //#if TARGET_OS_IPHONE
        //    self.body.velocity = GLKVector3DivideScalar(self.body.velocity, 1 );
        //#else
        self.velocity = RMXVector3DivideScalar(self.velocity, Float(1 + self.world.µAt(self.parent) + d.x))
        
        
        let forces = GLKVector3Make(
            (g.x + /* d.x + f.x +*/ n.x),
            (g.y +/* d.y + f.y +*/ n.y),//+body.acceleration.y,
            (g.z +/* d.z + f.z +*/ n.z)
        )
        
        //    self.body.forces.x += g.x + n.x;
        //    self.body.forces.y += g.y + n.y;
        //    self.body.forces.z += g.z + n.z;
        
        
        self.forces = GLKVector3Add(forces,RMXMatrix3MultiplyVector3(GLKMatrix3Transpose(self.orientation),self.acceleration));
        self.velocity = GLKVector3Add(self.velocity,self.forces);//transpos or?
        
        
        
        self.world.collisionTest(self.parent)
        
        //self.applyLimits()
        self.position = GLKVector3Add(self.position,self.velocity);
        
    }
    


    var upVector: GLKVector3 {
        return GLKMatrix3GetRow(self.orientation, 1)
//        return GLKVector3Make(Float(self.orientation.m12),Float(self.orientation.m22),Float(self.orientation.m32))
    }
    
    
    var leftVector: GLKVector3 {
        return GLKMatrix3GetRow(self.orientation, 0)
        //return GLKVector3Make(Float(self.orientation.m11),Float(self.orientation.m21),Float(self.orientation.m31))
    }
    
    var forwardVector: GLKVector3 {
        return GLKMatrix3GetRow(self.orientation, 2)
        //return GLKVector3Make(Float(self.orientation.m13),Float(self.orientation.m23),Float(self.orientation.m33))
    }
    
    func distanceTo(object:RMXObject) -> Float{
        return GLKVector3Distance(self.position,object.position)
    }
    
}