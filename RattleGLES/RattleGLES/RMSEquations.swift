//
//  RMSEquations.swift
//  RattleGLES
//
//  Created by Max Bilbow on 23/03/2015.
//  Copyright (c) 2015 Rattle Media Ltd. All rights reserved.
//

import Foundation
import GLKit

extension RMX {
    class func doASum(radius: Float, count i: Float, noOfShapes limit: Float ) -> GLKVector4{
        let radius = ceil(radius)
        return GLKVector4Make(randomFloat(radius*2)-radius,randomFloat(2*radius),randomFloat(radius*2)-radius, randomFloat(radius))
        
    }

    class func randomFloat(radius: Float) -> Float{
        return Float(random() % Int(radius))
    }

    class func circle ( count i: Float, radius r: Float) -> GLKVector4 {
        
        return  GLKVector4Make(sin(i)*sin(i)*r, sin(i)*cos(i)*r, cos(i)*cos(i)*r,1)
        
    }
    class func randomSpurt (count i: Int) -> GLKVector4 {
        let result = GLKVector4Make(
            Float(random() % 360 + i),Float(random() % 360 + i),
            Float(random() % 360 + i),Float(random() % 360 + 10)
        )
        return result;
    }

    class func equateContours(x: Float, y: Float)-> Float{
        return x + y;//((x*x +3*y*y) / 0.1 * 50*50 ) + (x*x +5*y*y)*exp2f(1-50*50)/2;
    }


    class func point_on_circle (radius: Float, angle_in_degrees: Float,  centre: Float)->GLKVector3
    {
        let I: Float = 1
        let x:Float = centre + radius * exp( PI * I * ( angle_in_degrees  / 180.0 ) )
        let y:Float = 0
        let z:Float = centre + radius * exp ( PI * I * ( angle_in_degrees  / 180.0 ) )
        return GLKVector3Make(x, y, z)
    }
}


