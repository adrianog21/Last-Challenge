//
//  FirstSight.swift
//  NewMaze
//
//  Created by Paolo Merlino on 04/06/2020.
//  Copyright © 2020 Adriano Gatto. All rights reserved.
//


import SpriteKit
import GameplayKit
import Foundation


class FirstSight: SKScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            if node.name == "YES" {
                let scene:SKScene = SecondSight(size: self.size)
                self.view?.presentScene(scene)
            }
            else if node.name == "NO"{
                lives -= 1
                if lives == 0 {
                    lives = 3
                    showLives(livesInScene: lives, heart: heartBeating())
                    level.newScene(scene: "Lose")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    
                    UIView.transition(with: self.view!, duration: 0.3, options: .transitionFlipFromRight, animations:
                        {
                         let vc = storyboard.instantiateViewController(withIdentifier: level.nextScene)
                         vc.view.frame = (self.view?.frame)!
                         vc.view.layoutIfNeeded()
                            self.view?.window?.rootViewController = vc
                    }, completion: { completed in
                    })
                }else {
                let scene:SKScene = FirstSight(size: self.size)
                self.view?.presentScene(scene)
                }
            }
        }
    }
    
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    
    override func sceneDidLoad() {
        addBackground()
        
        showLives(livesInScene: lives, heart: heartBeating() )
        let mirror = antiCheat()
        
        
        if lives == 3{
            let index = group.randomElement()!
            group = removeComparison(array: group, element: index)
            let defaults = UserDefaults.standard
            defaults.set(index, forKey: "index")
            let imageArray = declareAssets(index: index)
            let yesIndex = setRightImage(array: imageArray)
            addNode(node: imageArray[yesIndex], xpos: size.width/2, ypos: size.height/2)
            DispatchQueue.main.asyncAfter(deadline: .now() + 5){
                imageArray[yesIndex].removeFromParent()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    self.poseToCorners(array: imageArray, glowingIndex: yesIndex)
                    mirror.removeFromParent()
                }
            }
        }
        else{
            if lives != 0{
                let index = UserDefaults.standard.integer(forKey: "index")
                let imageArray = declareAssets(index: index)
                let yesIndex = setRightImage(array: imageArray)
                addNode(node: imageArray[yesIndex], xpos: size.width/2, ypos: size.height/2)
                DispatchQueue.main.asyncAfter(deadline: .now() + 5){
                    imageArray[yesIndex].removeFromParent()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                        self.poseToCorners(array: imageArray, glowingIndex: yesIndex)
                        mirror.removeFromParent()
                    }
                }
            }
            else{
                showLives(livesInScene: lives, heart: heartBeating())
                let movementLable = SKAction.move(to: CGPoint(x: size.width/2, y: size.height/2), duration: 2)
                let gameover = SKSpriteNode(imageNamed: "GameOver")
                gameover.position = CGPoint(x: size.width/2, y: size.height+30)
                gameover.addGlow()
                addChild(gameover)
                gameover.run(movementLable)
                
            }
            
        }
        
    }

}


