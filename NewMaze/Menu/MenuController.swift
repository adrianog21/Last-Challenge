//
//  MenuController.swift
//  NewMaze
//
//  Created by Adriano Gatto on 19/05/2020.
//  Copyright © 2020 Adriano Gatto. All rights reserved.
//

import GameKit
import UIKit
import SpriteKit

class Menu : UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let scene = GKScene(fileNamed: "MenuScene") {
                    
                    // Get the SKScene from the loaded GKScene
                    if let sceneNode = scene.rootNode as! MenuScene? {
                        
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
        
//        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(scroll), userInfo: nil, repeats: true)
    }
    
//    @objc func scroll(){
       
//
//        }
//    }
}

