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

protocol TransitionDelegate: SKSceneDelegate {
    func returnToMainMenu()
}

class SoundScene: SKScene {
    
    let rose = SKSpriteNode()
    let button = SKSpriteNode()
    
    var npos = CGPoint()
    var newAngle = CGFloat()
    var angle = CGFloat()
    var angle2 = CGFloat()
    
    var lastpos = CGFloat()
    var soundPos = CGFloat()
    
    override func sceneDidLoad() {
    super.sceneDidLoad()
        
        rose.texture = SKTexture(imageNamed: "windRose")
        rose.position = .zero
        rose.size = rose.texture?.size() as! CGSize
        addChild(rose)
        soundPos = CGFloat.random(in: -179...179)
        
        button.size = CGSize(width: 100, height: 50)
        button.color = .red
        button.position = CGPoint(x: 300, y: -100)
        button.name = "button"
        addChild(button)
        
    }
    
    override func didMove(to view: SKView) {
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           if let touch = touches.first {
               npos = touch.location(in: scene!)
            angle = atan2((npos.y - 0) , (npos.x - 0))
               lastpos = rose.zRotation
//            print(lastpos)
             }
        let node = self.nodes(at: npos).first
        
        if node?.name == "button"{
        checkPosition()
            print(soundPos)
            print(newAngle)
        }
       }
       
       override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
           for touch in touches {
               npos = touch.location(in: scene!)

            angle2 = atan2((npos.y - 0) , (npos.x - 0))
            rose.zRotation = (angle2 - angle) + lastpos
//            print(rose.zRotation)
           }
       }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastpos = rose.zRotation
    }
    
    fileprivate func checkPosition() {
        newAngle = rose.zRotation * CGFloat(180/Float.pi)
        
        if newAngle > soundPos - 10 && newAngle < soundPos + 10 {
            level.lastY(yPos: Float(level.getPosition().y - 30))
            level.getMinigame(game: "SoundGame")
            level.newScene(scene: "Win")
            guard let delegate = self.delegate else { return }
            self.view?.presentScene(nil)
            (delegate as! TransitionDelegate).returnToMainMenu()
            soundPos = CGFloat.random(in: -179...179)
            print(soundPos)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
