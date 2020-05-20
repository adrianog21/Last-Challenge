//
//  MenuScene.swift
//  NewMaze
//
//  Created by Adriano Gatto on 19/05/2020.
//  Copyright © 2020 Adriano Gatto. All rights reserved.
//

import UIKit
import SpriteKit

class MenuScene: SKScene {

    override func sceneDidLoad() {
        super.sceneDidLoad()
        print("ciao")
        
        let texture = SKTexture(imageNamed: "Background")
        
        for i in 0 ... 3 {
            let background = SKSpriteNode(texture: texture)
            background.anchorPoint = .zero
            background.size = CGSize(width: texture.size().width * 2, height: texture.size().height * 2)
            let start = CGPoint(x: (((background.size.width - 16.7) * CGFloat(i)) - 900), y: -210)
            background.position = start
            
            addChild(background)
            
        let moveleft = SKAction.moveTo(x: (start.x - background.size.width), duration: 10)
        let movereset = SKAction.moveTo(x: start.x, duration: 0)
            let loop = SKAction.sequence([moveleft, movereset])
            let moverepeat = SKAction.repeatForever(loop)
            
            background.run(moverepeat)
        }
    }
}
