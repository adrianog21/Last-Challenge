//
//  SightMinigame.swift
//  NewMaze
//
//  Created by Paolo Merlino on 20/05/2020.
//  Copyright © 2020 Adriano Gatto. All rights reserved.
//

import SpriteKit
import GameplayKit
import Foundation

var counter = 0

//  MARK:- GLOW EFFECT
extension SKSpriteNode {
    func addGlow(radius: Float = 30) {
        let effectNode = SKEffectNode()
        effectNode.zPosition = -2
        effectNode.shouldRasterize = true
        addChild(effectNode)
        effectNode.addChild(SKSpriteNode(texture: texture))
        effectNode.filter = CIFilter(name: "CIGaussianBlur", parameters: ["inputRadius":radius])
    }
}

class SightGame: SKScene {
//    MARK:- WINNER OR LOSER?
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            
            let winLable = SKLabelNode(text: "HAI VINTO")
            winLable.fontColor = UIColor.green
            winLable.position = CGPoint(x: size.width/2, y: size.height/2)
            let loseLable = SKLabelNode(text: "RIPROVA")
            loseLable.fontColor = UIColor.yellow
            loseLable.position = CGPoint(x: size.width/2, y: size.height/2)
            
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
//          WINNER
            if node.name == "Win"{
                counter = 0
                level.getMinigame(game: "SightGame")
                level.newScene(scene: "Win")
                addChild(winLable)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: level.nextScene)
                    vc.view.frame = (self.view?.frame)!
                    vc.view.layoutIfNeeded()
                    UIView.transition(with: self.view!, duration: 0.3, options: .transitionFlipFromRight, animations:
                        {
                            self.view?.window?.rootViewController = vc
                    }, completion: { completed in
                    })
                }
            }
//          LOSER
            else if node.name == "Lose"{
                counter += 1
                if counter != 3 {
                    addChild(loseLable)
                   DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    let back = SightGame(size: self.size)
                    self.view?.presentScene(back)
                    }
                }
                else{
                    
                        let back = SightGame(size: self.size)
                        self.view?.presentScene(back)
                    
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
//      BACKGROUND E PARTICELLE
        self.backgroundColor = .black
        let emitter = SKEmitterNode(fileNamed: "Dust")
        emitter?.position = .zero
        emitter?.advanceSimulationTime(30)
        emitter?.particleAlpha = 1
        addChild(emitter!)
//MARK:- GAME OVER SCENE
        if counter == 3 {

            counter = 0
            
            let movementLable = SKAction.move(to: CGPoint(x: size.width/2, y: size.height/2), duration: 2)
            let gameover = SKSpriteNode(imageNamed: "GameOver")
            gameover.position = CGPoint(x: size.width/2, y: size.height+30)
            gameover.addGlow()
            addChild(gameover)
            gameover.run(movementLable)
            level.newScene(scene: "Lose")
            DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: level.nextScene)
                vc.view.frame = (self.view?.frame)!
                vc.view.layoutIfNeeded()
                UIView.transition(with: self.view!, duration: 0.3, options: .transitionFlipFromRight, animations:
                    {
                        self.view?.window?.rootViewController = vc
                }, completion: { completed in
                })
            }
            
        }
//MARK:- NORMAL FLOW
        else{
        let lives = 3-counter
        let heart = SKSpriteNode(imageNamed: "heart25")
            heart.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            heart.position = CGPoint(x: size.width-100, y: size.height-30)
        let livesLable = SKLabelNode(text: "\(lives)")
            livesLable.fontColor = UIColor.white
            livesLable.fontSize = 20
            livesLable.position = CGPoint(x: heart.position.x+30, y: heart.position.y-7)
            addChild(heart)
            addChild(livesLable)
        //SPRITE DECLARATION IN AN ARRAY
        var imageVector: [SKSpriteNode] = [SKSpriteNode](repeating: .init(imageNamed: "0"), count: 16)
        for i in 0...15 {
            imageVector[i] = SKSpriteNode(imageNamed: "\(i)")
            imageVector[i].addGlow()
        }
        
        //COVER ALL OVER THE SCENE IN ORDER TO AVOID TOUCH IN THE STARTING OF THE GAME
        let untouch = SKSpriteNode(color: .clear, size: CGSize(width: size.width, height: size.height))
        untouch.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        untouch.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        untouch.zPosition = 1
        addChild(untouch)
        
        let index = Int.random(in: 0...15)
        randomImage(vector: imageVector, ind: index, nocheat: untouch)
        }
    }
    
//MARK:- WINNING IMAGE
    func randomImage(vector: [SKSpriteNode], ind: Int, nocheat: SKSpriteNode){
        switch ind {
        case 0,1,2,3:
            vector[0].name = "Lose"
            vector[1].name = "Lose"
            vector[2].name = "Lose"
            vector[3].name = "Lose"
            vector[ind].name = "Win"
            vector[ind].position = CGPoint(x: size.width/2, y: size.height/2)
            vector[ind].anchorPoint = CGPoint(x: 0.5, y: 0.5)
            vector[ind].zPosition = 0
            addChild(vector[ind])
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                vector[ind].removeFromParent()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    nocheat.removeFromParent()
                    self.position(node: vector[0], node2: vector[1], node3: vector[2], node4: vector[3])
                }
            }
        case 4,5,6,7:
            vector[4].name = "Lose"
            vector[5].name = "Lose"
            vector[6].name = "Lose"
            vector[7].name = "Lose"
            vector[ind].name = "Win"
            vector[ind].position = CGPoint(x: size.width/2, y: size.height/2)
            vector[ind].anchorPoint = CGPoint(x: 0.5, y: 0.5)
            vector[ind].zPosition = 0
            addChild(vector[ind])
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                vector[ind].removeFromParent()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    nocheat.removeFromParent()
                    self.position(node: vector[4], node2: vector[5], node3: vector[6], node4: vector[7])
                }
            }
        case 8,9,10,11:
            vector[8].name = "Lose"
            vector[9].name = "Lose"
            vector[10].name = "Lose"
            vector[11].name = "Lose"
            vector[ind].name = "Win"
            vector[ind].position = CGPoint(x: size.width/2, y: size.height/2)
            vector[ind].anchorPoint = CGPoint(x: 0.5, y: 0.5)
            vector[ind].zPosition = 0
            addChild(vector[ind])
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                vector[ind].removeFromParent()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    nocheat.removeFromParent()
                    self.position(node: vector[8], node2: vector[9], node3: vector[10], node4: vector[11])
                }
            }
        case 12,13,14,15:
            vector[12].name = "Lose"
            vector[13].name = "Lose"
            vector[14].name = "Lose"
            vector[15].name = "Lose"
            vector[ind].name = "Win"
            vector[ind].position = CGPoint(x: size.width/2, y: size.height/2)
            vector[ind].anchorPoint = CGPoint(x: 0.5, y: 0.5)
            vector[ind].zPosition = 0
            addChild(vector[ind])
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                vector[ind].removeFromParent()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    nocheat.removeFromParent()
                    self.position(node: vector[12], node2: vector[13], node3: vector[14], node4: vector[15])
                }
            }
        default:
            print("Davide De Vita")
        }
    }
//MARK:- DECISION SCENE
    func position(node: SKSpriteNode, node2: SKSpriteNode, node3: SKSpriteNode, node4:SKSpriteNode) {
        
        let left = size.width*0.25
        let right = size.width*0.75
        let up = size.height*0.75
        let down = size.height*0.25
        let movementLD = SKAction.move(to: CGPoint(x: left, y: down), duration: 1)
        let movementLU = SKAction.move(to: CGPoint(x: left, y: up), duration: 1)
        let movementRD = SKAction.move(to: CGPoint(x: right, y: down), duration: 1)
        let movementRU = SKAction.move(to: CGPoint(x: right, y: up), duration: 1)

        
        let decision = SKLabelNode(text: "Quale immagine hai appena visto?")
        decision.fontSize = 20
        decision.position = CGPoint(x: size.width/2, y: size.height-30)
        decision.zPosition = 0
        addChild(decision)
        
        node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        node.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(node)
        node.run(movementLU)
        
        node2.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        node2.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(node2)
        node2.run(movementRD)
        
        node3.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        node3.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(node3)
        node3.run(movementRU)
        
        node4.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        node4.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(node4)
        node4.run(movementLD)
        
    }

}


