//
//  GameViewController.swift
//  RattleGLES
//
//  Created by Max Bilbow on 23/03/2015.
//  Copyright (c) 2015 Rattle Media Ltd. All rights reserved.
//

class GameViewController : RMOViewController {
    lazy var dPad: RMXDPad = RMXDPad.New(self)
    
    override func getGeometry(shape: AnyObject?) -> RMOGeometry! {
        super.getGeometry(shape)
        return shape is RMSParticle ? (shape as! RMSParticle).geometry : nil
    }
    
    override var shapes: NSMutableArray {
        return self.dPad.world.shapes
    }
    var camera: RMXCamera {
        return self.dPad.activeCamera
    }
    override func viewDidLoad() {
        self.viewMatrix = self.dPad.activeCamera.modelViewMatrix
        super.viewDidLoad()
    }
    
    override func update(){
        self.dPad.animate()
        self.projectionMatrix = self.camera.getProjectionMatrix(Float(self.view.bounds.size.width), height: Float(self.view.bounds.size.height))
        self.viewMatrix = self.dPad.activeCamera.modelViewMatrix
        self.rotation += Float(self.timeSinceLastUpdate * 0.5)
        super.update()
    }
    
    override func glkView(view: GLKView!, drawInRect rect: CGRect) {
        glClearColor(1.0, 1.0, 1.0, 1.0);
        glClear(GLenum(GL_COLOR_BUFFER_BIT) | GLenum(GL_DEPTH_BUFFER_BIT));
        
        for p in self.dPad.world.sprites {
            
            if let shape = p.geometry { if p.shape != nil {
                let shape = p.geometry
                let scaleMatrix = shape!.scaleMatrix
                let translateMatrix = shape!.translationMatrix
                let rotationMatrix = shape!.rotationMatrix
                
                
                var matrixStack = GLKMatrixStackCreate(kCFAllocatorDefault).takeRetainedValue()
                
                GLKMatrixStackMultiplyMatrix4(matrixStack, translateMatrix)
                GLKMatrixStackMultiplyMatrix4(matrixStack, rotationMatrix)
                GLKMatrixStackMultiplyMatrix4(matrixStack, scaleMatrix)
                
                GLKMatrixStackPush(matrixStack)
                self.modelMatrix = GLKMatrixStackGetMatrix4(matrixStack);
                glBindVertexArrayOES(self.vertexArray);
                self.prepareEffectWithModelMatrix(self.modelMatrix, viewMatrix:self.viewMatrix, projectionMatrix: self.projectionMatrix)
                glDrawElements(GLenum(GL_TRIANGLES), GLsizei(shape!.sizeOfIndices / shape!.sizeOfIZero), GLenum(GL_UNSIGNED_BYTE), UnsafePointer<Void>())//nil or 0?
                
                glBindVertexArrayOES(0)

            }}
            
//            CFRelease(matrixStack as! GLKMatrixStackRef);
        }
    }
    
    func prepareEffectWithModelMatrix(modelMatrix: GLKMatrix4, viewMatrix:GLKMatrix4, projectionMatrix: GLKMatrix4) {
        self.effect.transform.modelviewMatrix = GLKMatrix4Multiply(viewMatrix, modelMatrix)
        self.effect.transform.projectionMatrix = projectionMatrix;
        self.effect.prepareToDraw()
    }

}
