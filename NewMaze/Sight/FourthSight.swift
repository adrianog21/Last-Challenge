//
//  FourthSight.swift
//  NewMaze
//
//  Created by Paolo Merlino on 04/06/2020.
//  Copyright © 2020 Adriano Gatto. All rights reserved.
//

import SpriteKit
import GameplayKit


class FourthSight: SKScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            if node.name == "YES"{
                removeAllChildren()
                let labelWin = SKLabelNode(text: "HAI VINTO")
                labelWin.fontColor = UIColor.green
                labelWin.fontSize = 40
                labelWin.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
                addChild(labelWin)
                level.getMinigame(game: "SightGame")
                level.newScene(scene: "Win")
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
            else if node.name == "NO"{
                lives -= 1
                if lives == 0 {
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
                
            else{
                print("mira meglio")
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
        let mirror = antiCheat()
        if firsTime4 == true{
            lives4 = lives3
            showLives(livesInScene: lives4, heart: heartBeating())
            firsTime4 = false
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
        
        else if lives4 != 0{
            showLives(livesInScene: lives4, heart: heartBeating())
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
            showLives(livesInScene: lives4, heart: heartBeating())
            let movementLable = SKAction.move(to: CGPoint(x: size.width/2, y: size.height/2), duration: 2)
            let gameover = SKLabelNode(text: "GAMEOVER")
            gameover.position = CGPoint(x: size.width/2, y: size.height+30)
            addChild(gameover)
            gameover.run(movementLable)
           
        }
    }
}
