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
        
        let emitter = SKEmitterNode(fileNamed: "Dust")
        emitter?.position = .zero
        emitter?.advanceSimulationTime(30)
        addChild(emitter!)
        
        let texture = SKTexture(imageNamed: "Background")
        
        for i in 0 ... 3 {
            let background = SKSpriteNode(texture: texture)
            background.anchorPoint = .zero
            background.alpha = 0.5
            background.size = CGSize(width: texture.size().width * 2, height: texture.size().height * 2)
            let start = CGPoint(x: (((background.size.width ) * CGFloat(i)) - 900), y: -180)
            background.position = start
            
            addChild(background)
            
        let moveleft = SKAction.moveTo(x: (start.x - background.size.width), duration: 90)
        let movereset = SKAction.moveTo(x: start.x, duration: 0)
            let loop = SKAction.sequence([moveleft, movereset])
            let moverepeat = SKAction.repeatForever(loop)
            
            background.run(moverepeat)
        }
    }
}
