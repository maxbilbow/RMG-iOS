//
//  GameView.swift
//  RMS SceneKit
//
//  Created by Max Bilbow on 21/03/2015.
//  Copyright (c) 2015 Rattle Media. All rights reserved.
//

import SceneKit

class GameView: NSOpenGLView {
    
    var keys: RMSKeys {
        return self.world.action.keys
    }
    var world: RMXWorld {
        return (self.openGLContext as! RMXGLContext).world!
    }// = RMXArt.initializeTestingEnvironment()

    var camera: RMXCamera? {
        return self.world.activeCamera
    }
    var sprite: RMSParticle? {
        return world.activeSprite
    }
    
    override func display() {
        self.world.animate()
        RMXLog()
        super.display()
    }
    override func keyDown(theEvent: NSEvent) {
        let keys = self.keys.match(theEvent.characters!)
        var s = theEvent.characters!
        for key in keys {
            let action = (key as? RMKey)?.action
            self.world.action.movement(-1.0, action: action)
            s += " ==> \((key as? RMKey)!.description)"
        }
        RMXLog(s)
        /*
        if (keys.keyStates['+']) {
            RMXGLProxy.itemBody.radius += 0.5;
            RMXGLProxy.itemBody.mass += 1;
        }
        if (keys.keyStates['_']) {
            RMXGLProxy.itemBody.radius -= 0.5;
        }
*/
        super.keyDown(theEvent)
    }

    
    override func keyUp(theEvent: NSEvent) {
        let keys = self.keys.match(theEvent.characters!)
        var s = theEvent.characters!
        for key in keys {
            let action = (key as? RMKey)?.action
            self.world.action.movement(0.0, action: action)
            s += " ==> \((key as? RMKey)!.description)"
            if action == "lockMouse" {
                
            }
        }
        RMXLog(s)
        /*
        if (key == 'i'){
            NSLog(@"%@",RMXGLProxy.activeSprite.camera.viewDescription);//me.toString();
        }
        
        switch (key)
        {
        default:
            if (RMX.isDebugging) NSLog(@"%i unassigned",key);
            break;
        case 27:             // ESCAPE key
            //glutSetKeyRepeat(true);
            exit (0);
            break;
            /*case 'l':
            SelectFromMenu(MENU_LIGHTING);
            break;
            case 'p':
            SelectFromMenu(MENU_POLYMODE);
            break;
            case 't':
            SelectFromMenu(MENU_TEXTURING);
            break;*/
        case 'z':
        [RMXGLProxy message:@"applyGravity" args:@(true)];
        break;
        case 'Z':
        [RMXGLProxy message:@"applyGravity" args:@(false)]; //args:false];
        break;
        case 'm':
        [RMXGLProxy.activeSprite.mouse toggleFocus];
        NSLog(@"m");
        if ( RMXGLProxy.activeSprite.mouse.hasFocus){
            //center();
            glutSetCursor(GLUT_CURSOR_NONE);
            
            [RMXGLProxy.activeSprite.mouse calibrateView:0 y:0];// [observer getMouse().x, [observer getMouse().y);
            [RMXGLProxy.activeSprite.mouse mouse2view:0 y:0];
            //glutWarpPointer(0,0);
            
        }
        else {
            glutSetCursor(GLUT_CURSOR_INHERIT);
        }
        break;
        case 32:
            // [observer stop();
            if (RMX.isDebugging) NSLog(@"%i: Space Bar",key);
            break;
        case 9:
            // [observer stop();
            if (RMX.isDebugging) NSLog(@"%i: TAB",key);
            break;
        case 'G':
        [RMXGLProxy.activeSprite toggleGravity];
        break;
        case '0':
        case '1':
        case '2':
        case '3':
        case '4':
        case '5':
        case '6':
        case '7':
        case '8':
        case '9':
        exit(0);//[sun lightSwitch:key];
        break;
        case 'S':
        // sun.setAnchor(&observer);
        break;
        case 'R':
        [RMXGLProxy message:@"resetWorld" args:nil];
        break;
        case 6: //cntrl f
            NSLog(@"ERROR: Toggle Full Screen not working");//[window toggleFullScreen];
            break;
        }
        // keys.keyStates[key] = false;
            
        */

    }
    
    override func touchesBeganWithEvent(event: NSEvent) {
        self.world.action.movement(1, action: "look", point: NSPoint(x: event.deltaX, y: event.deltaY))
        super.touchesBeganWithEvent(event)
    }
    override func mouse(aPoint: NSPoint, inRect aRect: NSRect) -> Bool {
        self.world.action.movement(1, action: "look", point: aPoint)
        return super.mouse(aPoint, inRect: aRect)
    }
    override func mouseMoved(theEvent: NSEvent) {
        self.world.action.movement(1, action: "look", point: NSPoint(x: theEvent.deltaX, y: theEvent.deltaY))
        super.mouseMoved(theEvent)
    }
    override func mouseDragged(theEvent: NSEvent) {
        self.world.action.movement(1, action: "look", point: NSPoint(x: theEvent.deltaX, y: theEvent.deltaY))
        super.mouseMoved(theEvent)
    }

    override func mouseDown(theEvent: NSEvent) {
        /* Called when a mouse click occurs */
        
        // check what nodes are clicked
//        let p = self.convertPoint(theEvent.locationInWindow, fromView: nil)
        RMXLog("\(theEvent.buttonNumber)")
        self.sprite?.actions?.grabItem()
        
//        pointOfView?.camera?.usesOrthographicProjection = true
       
        super.mouseDown(theEvent)
    }
    

    override func update() {
        //self.camera?.updateSCNView(gameView: self)
//        self.camera?.updateSCNView(gameView: self)
        self.world.animate()
        
       RMXLog()
        super.update()
    }
    override func prepareOpenGL() {
        RMXLog()
        super.prepareOpenGL()
    }
    
    override func rightMouseUp(theEvent: NSEvent) {
        RMXLog("\(theEvent.buttonNumber)")
        self.sprite?.actions?.throwItem(5)
        super.rightMouseUp(theEvent)
    }
    override func needsToDrawRect(aRect: NSRect) -> Bool {
        self.update()
        //RMXLog(self.camera?.viewDescription)
        return super.needsToDrawRect(aRect)
    }
    
}
