//
//  GameViewController.swift
//  NewMaze
//
//  Created by Adriano Gatto on 14/05/2020.
//  Copyright © 2020 Adriano Gatto. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                
                // Copy gameplay related content over to the scene
//                sceneNode.entities = scene.entities
//                sceneNode.graphs = scene.graphs
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
//                    view.showsPhysics = true
                    
//                    newScene(scene: "Minigame")
                    
                }
            }
        }
    }
    

        func newScene(scene : String) {
//            let VC = UIStoryboard(name: "Main", bundle:  Bundle.main).instantiateViewController(withIdentifier: scene) as? UINavigationController
//            print(VC as Any)
            let VC = self.storyboard!.instantiateViewController(withIdentifier: scene) as! UINavigationController
            self.navigationController?.present(VC, animated: false, completion: nil)
        }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
