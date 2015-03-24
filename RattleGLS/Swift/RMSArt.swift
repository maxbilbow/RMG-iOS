//
//  RMSArt.swift
//  RattleGL
//
//  Created by Max Bilbow on 11/03/2015.
//  Copyright (c) 2015 Rattle Media. All rights reserved.
//

import Foundation


public class RMXArt : RMXObject {
    static let colorBronzeDiff: [Float]  = [ 0.8, 0.6, 0.0, 1.0 ]
    static let colorBronzeSpec: [Float]  = [ 1.0, 1.0, 0.4, 1.0 ]
    static let colorBlue: [Float]        = [ 0.0, 0.0, 0.1, 1.0 ]
    static let colorNone: [Float]        = [ 0.0, 0.0, 0.0, 0.0 ]
    static let colorRed: [Float]         = [ 0.1, 0.0, 0.0, 1.0 ]
    static let colorGreen: [Float]       = [ 0.0, 0.1, 0.0, 1.0 ]
    static let colorYellow: [Float]      = [ 1.0, 0.0, 0.0, 1.0 ]
    static let nillVector: [Float]       = [ 0  ,   0,  0,  0   ]
    
    
    class func initializeTestingEnvironment() -> RMSWorld {
    

        let world: RMSWorld = RMSWorld()
        
        //if (world.observer == nil ){ fatalError(__FUNCTION__) }
    
    
        let sun = RMSParticle(world: world)
        //[sun setRAxis:GLKVector3Make(0, 0, 1)];
        sun.body.radius = 100
        sun.shape!.color = GLKVector4Make(0.5,0.5,0.5,0.5)
        sun.shape!.makeAsSun(rDist: world.body.radius * 2, isRotating: true)
        sun.shape!.geometry = RMOGeometry.SPHERE(sun)
        world.insertSprite(sun)
        
        let axisColors = [colorBlue , colorRed , colorGreen]
        
        let ZX = RMSParticle(world: world)
//        ZX.shape!.geometry = RMOGeometry.PLANE(ZX)//TODO
        ZX.shape!.color = GLKVector4Make(0.8,1.2,0.8,0.5)
        ZX.isAnimated = false
        ZX.body.position = GLKVector3Make(ZX.body.position.x, 0, ZX.body.position.z)
        world.insertSprite(ZX)
        
        RMXArt.drawAxis(world)
        RMXArt.randomObjects(world)
        

        return world
        
    }
    
    class func drawAxis(world: RMSWorld) {//xCol y:(float*)yCol z:(float*)zCol{
    
    //BOOL gravity = false;
        let shapeRadius: Float = 10
        let axisLenght = world.body.radius * 2
        let shapesPerAxis: Float = axisLenght / (shapeRadius * 2)
        let step: Float = axisLenght / shapesPerAxis
        
        func drawAxis(axis: String) {
            var point =  -world.body.radius
            var color: [Float]
            switch axis {
            case "x":
                color = self.colorRed
                break
            case "y":
                color = self.colorGreen
                break
            case "z":
                color = self.colorBlue
                break
            default:
                fatalError(__FUNCTION__)
            }
            for (var i: Float = 0; i < shapesPerAxis; ++i){
                let position = GLKVector3Make(axis == "x" ? point : 0, axis == "y" ? point : 0, axis == "z" ? point : 0)
                point += step
                let object:RMSParticle = RMSParticle(world: world)
                object.addInitCall( {
                    object.setHasGravity(false)
                    object.body.radius = shapeRadius
                    object.body.position = position
                    object.shape!.visible = true
//                    object.shape?.setRenderer(DrawCubeWithTextureCoords)
                    object.shape!.geometry = RMOGeometry.CUBE(object)
            
                    object.shape!.color = GLKVector4Make(color[0], color[1], color[2], color[3])
                    object.isAnimated = false
                })
                world.insertSprite(object)
            }
            
            
        }
        drawAxis("x")
        drawAxis("y")
        drawAxis("z")
    }
    
    class func randomObjects(world: RMSWorld )    {
    //int max =100, min = -100;
    //BOOL gravity = true;
        let noOfShapes: Float = 2000
        
        for(var i: Float = -noOfShapes / 2; i < noOfShapes / 2; ++i) {
            var randPos: [Float]
            var X: Float = 0; var Y: Float = 0; var Z: Float = 0
            func thisRandom(inout x: Float, inout y: Float, inout z: Float) -> [Float] {
                do {
                    let points = RMX.doASum(Float(world.body.radius), count: i, noOfShapes: noOfShapes )
                    x = points.x
                    y = points.y
                    z = points.z
                } while GLKVector3Distance(GLKVector3Make(x,y,z), RMXVector3Zero) > world.body.radius
                return [ x, y, z ]
            }
            randPos = thisRandom(&X,&Y,&Z)
            let chance = 1//(rand() % 6 + 1);
        randPos[1] = randPos[1] + 50
        
        //gravity = !gravity;
            let object: RMSParticle = RMSParticle(world: world)
//            if(false){//(rand() % 10000) == 1) {
//                object.shape.makeAsSun(rDist: 0, isRotating:false)
//            }
        
        if(random() % 50 == 1) {
//            object.shape!.geometry = RMOGeometry.SPHERE(object) ///TODO
        } else {
            object.shape!.geometry = RMOGeometry.CUBE(object)
        }
        
        object.setHasGravity(false) //(rand()% 100) == 1
        object.body.radius = Float(random() % 3 + 2)
        object.body.position = GLKVector3Make(randPos[0], randPos[1], randPos[2])
        object.body.mass = Float(random()%15+2)/10;
        object.body.dragC = Float(random() % 99+1)/100;
        object.shape!.color = RMXRandomColor()
        world.insertSprite(object)
        
        
        }
    }
    
    
    class func randomColor() -> GLKVector4 {
    //float rCol[4];
        var rCol = GLKVector4Make(
            Float(random() % 800)/500,
            Float(random() % 800)/500,
            Float(random() % 800)/500,
        1)

    return rCol
    }

}


func RMXRandomColor() -> GLKVector4 {
    //float rCol[4];
    return GLKVector4Make(
        Float(random() % 800)/500,
        Float(random() % 800)/500,
        Float(random() % 800)/500,
        1.0)
}