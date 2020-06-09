//
//  FuncSight.swift
//  NewMaze
//
//  Created by Paolo Merlino on 04/06/2020.
//  Copyright © 2020 Adriano Gatto. All rights reserved.
//

import SpriteKit
import GameplayKit


var lives: Int = 3
var lives2: Int = 3
var lives3: Int = 3
var lives4: Int = 3
var group = [0,1,2,3]
var firsTime2: Bool = true
var firsTime3: Bool = true
var firsTime4: Bool = true


public extension SKScene{
    
    func removeComparison(array: [Int], element: Int) -> [Int] {
        var copyArray = array
        var i = 0
        while copyArray.count == array.count {
            
            if array[i] == element{
                copyArray.remove(at: i)
            }else{
                i += 1
            }
        }
        return copyArray
    }
    
    func declareAssets(index: Int) -> [SKSpriteNode]{
        switch index {
        case 0:
            var imageVector: [SKSpriteNode] = [SKSpriteNode](repeating: .init(imageNamed: "0"), count: 4)
            for i in 0...3 {
                imageVector[i] = SKSpriteNode(imageNamed: "\(i)")
            };return imageVector
        case 1:
            var imageVector: [SKSpriteNode] = [SKSpriteNode](repeating: .init(imageNamed: "0"), count: 4)
            for i in 0...3 {
                imageVector[i] = SKSpriteNode(imageNamed: "\(i+4)")
            };return imageVector
        case 2:
            var imageVector: [SKSpriteNode] = [SKSpriteNode](repeating: .init(imageNamed: "0"), count: 4)
            for i in 0...3 {
                imageVector[i] = SKSpriteNode(imageNamed: "\(i+8)")
            };return imageVector
        case 3:
            var imageVector: [SKSpriteNode] = [SKSpriteNode](repeating: .init(imageNamed: "0"), count: 4)
            for i in 0...3 {
                imageVector[i] = SKSpriteNode(imageNamed: "\(i+12)")
            };return imageVector
        default:
            let imageVector: [SKSpriteNode] = [SKSpriteNode](repeating: .init(), count: 1)
            print("DAVIDE DE VITA")
            return imageVector
        }
        
    }
    
    func antiCheat() -> SKSpriteNode{
        let mirror = SKSpriteNode(color: .clear, size: CGSize(width: size.width, height: size.height))
        mirror.name = "CIAO"
        addNode(node: mirror, xpos: size.width/2, ypos: size.height/2)
        mirror.zPosition = 2
        return mirror
       }
    
    func setRightImage(array: [SKSpriteNode]) -> Int {
        let index = Int.random(in: 0...3)
        for node in array{
           node.name = "NO"
        }
        array[index].name = "YES"
        return index
    }
    
    
    func addNode(node: SKSpriteNode, xpos: CGFloat, ypos: CGFloat) {
        node.position = CGPoint(x: xpos, y: ypos)
        node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        node.zPosition = 1
        node.addGlow()
        addChild(node)
    }
    
    func posetoupleft(node: SKSpriteNode){
        let left = size.width*0.25
        let up = size.height*0.75
        node.position = CGPoint(x: left, y: up)
    }
    
    func posetodownleft(node: SKSpriteNode){
        let left = size.width*0.25
        let down = size.height*0.25
        node.position = CGPoint(x: left, y: down)
    }
    
    func posetoupright(node: SKSpriteNode){
        let right = size.width*0.75
        let up = size.height*0.75
        node.position = CGPoint(x: right, y: up)
    }
    func posetodownright(node: SKSpriteNode){
        let right = size.width*0.75
        let down = size.height*0.25
        node.position = CGPoint(x: right, y: down)
    }
    func poseToCorners(array: [SKSpriteNode]){
        var arrayshuffled = array
        arrayshuffled.shuffle()
        posetoupleft(node: arrayshuffled[0])
        posetodownleft(node: arrayshuffled[1])
        posetoupright(node: arrayshuffled[2])
        posetodownright(node: arrayshuffled[3])
        for item in arrayshuffled {
            
            addChild(item)
        }
    }

}

public extension SKSpriteNode{
    func addGlow(radius: Float = 30) {
        let effectNode = SKEffectNode()
        effectNode.zPosition = -2
        effectNode.shouldRasterize = true
        addChild(effectNode)
        effectNode.addChild(SKSpriteNode(texture: texture))
        effectNode.filter = CIFilter(name: "CIGaussianBlur", parameters: ["inputRadius":radius])
    }
}

