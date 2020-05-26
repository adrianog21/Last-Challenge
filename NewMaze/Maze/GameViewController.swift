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

weak var gamecontroller = GameViewController()

class GameViewController: UIViewController {
    
    
    @IBOutlet weak var blackView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gamecontroller = self
        
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
//                    view.showsNodeCount = true
                    
//                    view.showsPhysics = true
                    
                    UIView.animate(withDuration: 3, animations: {self.blackView.alpha = 0})
                    
                }
            }
        }
    }
    

        func newScene(scene : String) {
            print(scene)

            if scene == "MazeGame"{
                _ = navigationController?.popViewController(animated: true)
                _ = navigationController?.popToRootViewController(animated: true)
            }else{
//            let VC = UIStoryboard(name: "Main", bundle:  Bundle.main).instantiateViewController(withIdentifier: scene) as? UINavigationController
//            print(VC as Any)
            let VC = self.storyboard!.instantiateViewController(withIdentifier: scene) as! UINavigationController
            self.navigationController?.present(VC, animated: false, completion: nil)
//                self.navigationController.pre
        }
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
