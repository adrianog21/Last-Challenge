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
        let label = SKLabelNode(text: "Are You Ready?")
        label.color = .white
        label.position = CGPoint(x: size.width * 0.5, y: size.height - 30)
        addChild(label)
        

        let textStart = SKLabelNode(text: "Yes")
        textStart.name = "START"
        textStart.position = CGPoint(x: size.width*0.25, y: size.height*0.5)
        textStart.fontColor = .white
        textStart.fontSize = 40
        addChild(textStart)
        

        let textBack = SKLabelNode(text: "No")
        textBack.position = CGPoint(x: size.width*0.75, y: size.height*0.5)
        textBack.fontColor = .white
        textBack.fontSize = 40
        addChild(textBack)
        textBack.name = "MAZE"
    }
}


