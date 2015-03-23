//
//  GameViewController.swift
//  RMS SceneKit
//
//  Created by Max Bilbow on 21/03/2015.
//  Copyright (c) 2015 Rattle Media. All rights reserved.
//

import SceneKit
import QuartzCore

class GameViewController: NSViewController {
    
    @IBOutlet weak var gameView: GameView!
    

    /*
    func renderer(aRenderer: SCNSceneRenderer, updateAtTime time: NSTimeInterval) {
        if self.gameView != nil && self.gameView.camera?.pov != nil {
            self.gameView.update()///.camera?.updateSCNView(gameView: self.gameView)
            //RMXLog(self.gameView.camera!.viewDescription)
            //        cameraNode.position.x = self.observer()!.position[0]
            //        cameraNode.position.y = self.observer()!.position[1]
            //        cameraNode.position.z = self.observer()!.position[2]
            //cameraNode.position = (self.view as SCNView).pointOfView!.position
            //cameraNode.position.z += 15
            //RMXLog("--- Camera Orientation")
            //RMXLog("w\(self.cameraNode.orientation.w.toData()), x\(self.cameraNode.orientation.w.toData()), y\(self.cameraNode.orientation.w.toData()), z\(self.cameraNode.orientation.w.toData())")
            //(self.gameView.scene as! RMXScene).update()
        }
        else {
            RMXLog("--- Warning: observer may not be initialised")
        }
    }
    */
    override func awakeFromNib(){
        // create a new scene
        let scene: RMXGLContext = RMXGLContext()
        scene.buildScene()
        self.gameView!.openGLContext = scene
        
        //(1) Allocate and initialize an instance of GLKBaseEffect
        
        let directionalLightEffect = GLKBaseEffect()
        
        //(2) Set the desired properties on the effect
        
        // Configure light0
        directionalLightEffect.light0.position = GLKVector4Make(10,10,20,1)
//        directionalLightEffect.light0.diffuseColor = diffuseColor
//        directionalLightEffect.light0.ambientColor = ambientColor
        
        // Configure material
        //directionalLightEffect.material.diffuseColor = materialDiffuseColor;
//        directionalLightEffect.material.ambientColor = materialAmbientColor;
//        directionalLightEffect.material.specularColor = materialSpecularColor;
        directionalLightEffect.material.shininess = 10.0
        
       // (3) Initialize vertex attribute / vertex array state preferrably with a vertex array object
        //for the model or scene to be drawn.
        
//        glGenVertexArraysOES(1, &vaoName)
//        glBindVertexArrayOES(vaoName)
        
        // Create and initialize VBO for each vertex attribute
        // The example below shows an example of setup up the position vertex attribute.
        // Repeat the steps below for each additional desired attribute: normal, color, texCoord0, texCoord1.
        
//        glGenBuffers(1, &positionVBO);
//        glBindBuffer(GL_ARRAY_BUFFER, positionVBO);
//        glBufferData(GL_ARRAY_BUFFER, vboSize, dataBufPtr, GL_STATIC_DRAW);
//        glVertexAttribPointer(GLKVertexAttribPosition, size, type, normalize, stride, NULL);
//        glEnableVertexAttribArray(GLKVertexAttribPosition);
//        
        //... repeat the steps above for other desired vertex attributes
        
//        glBindVertexArrayOES(0) // unbind the VAO we created above
        
//        (4) For each frame drawn:  Update properties that change per frame.  Synchronize the changed effect state
//        by calling -[GLKBaseEffect prepareToDraw].  Draw the model with the effect
        
        //directionalLightEffect.transform.modelviewMatrix = modelviewMatrix;
        directionalLightEffect.prepareToDraw()
//        glBindVertexArrayOES(vaoName)
//        glDrawArrays(GL_TRIANGLE_STRIP, 0, vertCt)
    }

    
    
}
