//
//  ReadySight.swift
//  NewMaze
//
//  Created by Paolo Merlino on 16/06/2020.
//  Copyright © 2020 Adriano Gatto. All rights reserved.
//

import SpriteKit
import GameplayKit
import Foundation



class ReadyScene: SKScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            if node.name == "START" {
                let scene:SKScene = FirstSight(size: self.size)
                self.view?.presentScene(scene)
            }
            else if node.name == "MAZE"{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                UIView.transition(with: self.view!, duration: 0.3, options: .transitionFlipFromRight, animations:
                    {
                        let vc = storyboard.instantiateViewController(withIdentifier: level.nextScene)
                        vc.view.frame = (self.view?.frame)!
                        vc.view.layoutIfNeeded()
                        self.view?.window?.rootViewController = vc
                }, completion: { completed in
                })
            }
        }
    }
    
    
    override func sceneDidLoad(){
        addBackground()
        let label = SKLabelNode(text: "Sei Pronto?")
        label.color = .white
        label.position = CGPoint(x: size.width * 0.5, y: size.height - 30)
        addChild(label)
        
        let buttonStart = SKShapeNode(rectOf: CGSize(width: 150, height: 100), cornerRadius: 25)
        buttonStart.name = "START"
        buttonStart.lineWidth = 1
        buttonStart.position = CGPoint(x: size.width*0.5, y: size.height*0.5 + 30)
        let textStart = SKLabelNode(text: "Si")
        buttonStart.addChild(textStart)
        addChild(buttonStart)
        
        let buttonBack = SKShapeNode(rectOf: CGSize(width: 150, height: 100), cornerRadius: 25)
        buttonBack.name = "MAZE"
        buttonBack.lineWidth = 1
        buttonBack.position = CGPoint(x: buttonStart.position.x, y: buttonStart.position.y - 110)
        let textBack = SKLabelNode(text: "No")
        buttonBack.addChild(textBack)
        addChild(buttonBack)
    }
}


