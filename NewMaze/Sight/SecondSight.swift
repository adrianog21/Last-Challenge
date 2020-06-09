//
//  SecondSight.swift
//  NewMaze
//
//  Created by Paolo Merlino on 04/06/2020.
//  Copyright © 2020 Adriano Gatto. All rights reserved.
//

import SpriteKit
import GameplayKit


class SecondSight: SKScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            if node.name == "YES"{
                let scene:SKScene = ThirdSight(size: self.size)
                self.view?.presentScene(scene)
                print("SI")
            }
            else if node.name == "NO"{
                lives2 -= 1
                let scene: SKScene = SecondSight(size: self.size)
                self.view?.presentScene(scene)
                print("NO")
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
        let mirror = antiCheat()
        
        if firsTime2 == true{
            lives2 = lives
            firsTime2 = false
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
                    self.poseToCorners(array: imageArray)
                    mirror.removeFromParent()
                }
            }
            
        }
        
        else if lives2 != 0{
            let index = UserDefaults.standard.integer(forKey: "index")
            let imageArray = declareAssets(index: index)
            let yesIndex = setRightImage(array: imageArray)
            addNode(node: imageArray[yesIndex], xpos: size.width/2, ypos: size.height/2)
            DispatchQueue.main.asyncAfter(deadline: .now() + 5){
                imageArray[yesIndex].removeFromParent()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    self.poseToCorners(array: imageArray)
                    mirror.removeFromParent()
                }
            }
        }
        else{
            let movementLable = SKAction.move(to: CGPoint(x: size.width/2, y: size.height/2), duration: 2)
            let gameover = SKLabelNode(text: "GAMEOVER")
            gameover.position = CGPoint(x: size.width/2, y: size.height+30)
            addChild(gameover)
            gameover.run(movementLable)
            
        }
    }
}
