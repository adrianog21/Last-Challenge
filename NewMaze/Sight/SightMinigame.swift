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

extension SKSpriteNode {

    func addGlow(radius: Float = 30) {
        let effectNode = SKEffectNode()
        effectNode.zPosition = -10
        effectNode.shouldRasterize = true
        addChild(effectNode)
        effectNode.addChild(SKSpriteNode(texture: texture))
        effectNode.filter = CIFilter(name: "CIGaussianBlur", parameters: ["inputRadius":radius])
    }
}

class SightGame: SKScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let winLable = SKLabelNode(text: "HAI VINTO")
            winLable.fontColor = UIColor.green
            winLable.position = CGPoint(x: size.width/2, y: size.height/2)
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            if node.name == "Win"{
                addChild(winLable)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "MazeGame")
                    vc.view.frame = (self.view?.frame)!
                    vc.view.layoutIfNeeded()
                    UIView.transition(with: self.view!, duration: 0.3, options: .transitionFlipFromRight, animations:
                        {
                            self.view?.window?.rootViewController = vc
                    }, completion: { completed in
                    })
                }
            }
            else if node.name == "Lose"{
                let back = SightGame(size: self.size)
                self.view?.presentScene(back)
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
        // Background e Particelle
        self.backgroundColor = .black
        let emitter = SKEmitterNode(fileNamed: "Dust")
        emitter?.position = .zero
        emitter?.advanceSimulationTime(30)
        emitter?.particleAlpha = 1
        addChild(emitter!)
        
//
        var imageVector: [SKSpriteNode] = [SKSpriteNode](repeating: .init(imageNamed: "0"), count: 16)
        for i in 0...15 {
            imageVector[i] = SKSpriteNode(imageNamed: "\(i)")
            imageVector[i].addGlow()
            imageVector[i].name = "aggiunto\(i)"
            print(imageVector[i].name as Any)
        }
        
        
        let untouch = SKSpriteNode(color: .clear, size: CGSize(width: 0, height: 0))
        untouch.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        untouch.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        untouch.zPosition = 1
//        addChild(untouch)
        
//        let index = Int.random(in: 0...15)
        let index = 2
        randomImage(vector: imageVector, ind: index, nocheat: untouch)
        
    }
    
    
    func randomImage(vector: [SKSpriteNode], ind: Int, nocheat: SKSpriteNode){
        switch ind {
        case 0,1,2,3:
            vector[0].name = "Lose"
            vector[1].name = "Lose"
            vector[2].name = "Lose"
            vector[3].name = "Lose"
            vector[ind].position = CGPoint(x: size.width/2, y: size.height/2)
            vector[ind].anchorPoint = CGPoint(x: 0.5, y: 0.5)
            vector[ind].zPosition = 0
            vector[ind].name = "Win"
            addChild(vector[ind])
            let seconds = 5.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                vector[ind].removeFromParent()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
//                    nocheat.removeFromParent()
                    self.position(node: vector[0], node2: vector[1], node3: vector[2], node4: vector[3])
                }
            }
        case 4,5,6,7:
            vector[4].name = "Lose"
            vector[5].name = "Lose"
            vector[6].name = "Lose"
            vector[7].name = "Lose"
            vector[ind].position = CGPoint(x: size.width/2, y: size.height/2)
            vector[ind].anchorPoint = CGPoint(x: 0.5, y: 0.5)
            vector[ind].zPosition = 0
            vector[ind].name = "Win"
            addChild(vector[ind])
            let seconds = 5.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
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
            vector[ind].position = CGPoint(x: size.width/2, y: size.height/2)
            vector[ind].anchorPoint = CGPoint(x: 0.5, y: 0.5)
            vector[ind].zPosition = 0
            vector[ind].name = "Win"
            addChild(vector[ind])
            let seconds = 5.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
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
            vector[ind].position = CGPoint(x: size.width/2, y: size.height/2)
            vector[ind].anchorPoint = CGPoint(x: 0.5, y: 0.5)
            vector[ind].zPosition = 0
            vector[ind].name = "Win"
            addChild(vector[ind])
            let seconds = 5.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
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
    
    func position(node: SKSpriteNode, node2: SKSpriteNode, node3: SKSpriteNode, node4:SKSpriteNode) {
        let decision = SKLabelNode(text: "Quale immagine hai appena visto?")
        decision.fontSize = 20
        let movementLD = SKAction.move(to: CGPoint(x: size.width*0.25, y: size.height*0.25), duration: 1)
        let movementLU = SKAction.move(to: CGPoint(x: size.width*0.25, y: size.height*0.75), duration: 1)
        let movementRD = SKAction.move(to: CGPoint(x: size.width*0.75, y: size.height*0.25), duration: 1)
        let movementRU = SKAction.move(to: CGPoint(x: size.width*0.75, y: size.height*0.75), duration: 1)
        let movementText = SKAction.move(to: CGPoint(x: size.width/2, y: size.height-30), duration: 1)
        
        decision.position = CGPoint(x: size.width/2, y: size.height/2)
        decision.zPosition = 0
        addChild(decision)
        decision.run(movementText)
        
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


