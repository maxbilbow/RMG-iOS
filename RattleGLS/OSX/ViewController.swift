//
//  ViewController.swift
//  Rattle Physics Beta
//
//  Created by Max Bilbow on 18/03/2015.
//  Copyright (c) 2015 Rattle Media. All rights reserved.
//

import Cocoa
import SceneKit

public class ViewController: NSViewController {
    
//    @IBOutlet weak var glView: RMSView! = RMSView()
    
   
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    
    }

    override public var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    
    @IBAction func launchGame(sender: AnyObject?) {
        //glView = RMSView()
//        self.scene = self.initGame()
//        self.glView.camera = self.camera
//        self.glView.setupGL()
        self.view = RMSView(frame: NSRect(), pixelFormat: NSOpenGLPixelFormat())
        
        return
    }
    
    
    private func initGame() -> RMXWorld? {
        return RMX.buildScene()
        
    }
}

