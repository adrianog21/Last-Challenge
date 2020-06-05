//
//  SoundViewController.swift
//  NewMaze
//
//  Created by Martina Dinardo on 05/06/2020.
//  Copyright © 2020 Adriano Gatto. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class SoundViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       if let view = self.view as! SKView? {
                   // Load the SKScene from 'GameScene.sks'
                   if let scene = SKScene(fileNamed: "SoundScene") {
                       
                       
                       // Set the scale mode to scale to fit the window
                       scene.scaleMode = .aspectFill

                       // Present the scene
                       view.presentScene(scene)
                   }
    }
    
    
     var shouldAutorotate: Bool {
        return false
    }

     var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
        }
        
         var prefersStatusBarHidden: Bool {
            return true
        }
    }
}
