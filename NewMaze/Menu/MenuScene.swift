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

class MenuScene : SKScene {
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
         for i in 0 ... 1 {
            
            let texture = SKTexture(image: #imageLiteral(resourceName: "Group 113.png"))
                   let background = SKSpriteNode(texture: texture)
            background.zPosition = -30
            background.anchorPoint = .zero
            
            addChild(background)

                   let moveLeft = SKAction.moveTo(x: -background.frame.width, duration: 10)
                   let reset = SKAction.moveTo(x: background.frame.width, duration: 0)
                   let loop = SKAction.sequence([moveLeft, reset])
                   let repeatAction = SKAction.repeatForever(loop)
    }
    
}
}
