//
//  SoundScene.swift
//  NewMaze
//
//  Created by Martina Dinardo on 05/06/2020.
//  Copyright © 2020 Adriano Gatto. All rights reserved.
//


import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class SoundScene: SKScene {
    
    let rose = SKSpriteNode()
    
    var npos = CGPoint()
    
    var lastpos = CGFloat()
    
    override func sceneDidLoad() {
    super.sceneDidLoad()
        
        rose.texture = SKTexture(imageNamed: "windRose")
        rose.position = .zero
        rose.size = rose.texture?.size() as! CGSize
        addChild(rose)
    }
    
    override func didMove(to view: SKView) {
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           if let touch = touches.first {
               npos = touch.location(in: scene!)
//               lastpos = rose.zRotation
//            print(lastpos)
             }
       }
       
       override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
           for touch in touches {
               npos = touch.location(in: scene!)

            var angle = atan2((npos.y - 0) , (npos.x - 0)) 
            rose.zRotation = angle - lastpos
//            print(rose.zRotation)
           }
       }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastpos = rose.zRotation
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
