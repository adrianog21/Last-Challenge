//
//  MenuScene.swift
//  NewMaze
//
//  Created by Adriano Gatto on 19/05/2020.
//  Copyright © 2020 Adriano Gatto. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit
import GameplayKit

class MenuScene : SKScene {
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
//          if let scene = GKScene(fileNamed: "MenuScene") {
//                    
//                    // Get the SKScene from the loaded GKScene
//                    if let sceneNode = scene.rootNode as! MenuScene? {
//                        
//                        print("111")
//                        // Copy gameplay related content over to the scene
//        //                sceneNode.entities = scene.entities
//        //                sceneNode.graphs = scene.graphs
//                        
//                        // Set the scale mode to scale to fit the window
//                        sceneNode.scaleMode = .aspectFill
//                        
//                        // Present the scene
//                        if let view = self.view as! SKView? {
//                            view.presentScene(sceneNode)
//        
//    }
//            }
//        }
        
        let texture = SKTexture(imageNamed: "Group 113.png")

             for i in 0 ... 1 {
                
                       let background = SKSpriteNode(texture: texture)
                background.zPosition = -30
                background.anchorPoint = .zero
                background.position = CGPoint(x: 110, y: 110)
                background.size = CGSize(width: texture.size().width, height: texture.size().height)
                
                addChild(background)
                print("added")

                       let moveLeft = SKAction.moveTo(x: -background.frame.width, duration: 10)
                       let reset = SKAction.moveTo(x: background.frame.width, duration: 0)
                       let loop = SKAction.sequence([moveLeft, reset])
                       let repeatAction = SKAction.repeatForever(loop)
                background.run(repeatAction)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        
    
}
}
