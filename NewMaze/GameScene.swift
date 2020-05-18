//
//  GameScene.swift
//  NewMaze
//
//  Created by Adriano Gatto on 14/05/2020.
//  Copyright © 2020 Adriano Gatto. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let holeCategory:UInt32 = 0x1 << 0
    let playerCategory:UInt32 = 0x1 << 1
    let wallCategory:UInt32 = 0x1 << 2
    
    var game = GameViewController()
//    let newScene = LoadLevel()
    
    var tileNodes = [SKSpriteNode]()
    
    var npos = CGPoint()
    
    let lightNode = SKLightNode()
    let player = SKSpriteNode()
    let pointing = SKSpriteNode()
    
    
    var move = false
    var point = SKNode()
    
    let gameCamera = SKCameraNode()
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func sceneDidLoad() {

        self.lastUpdateTime = 0

        lightNode.position = CGPoint(x: 0, y: 0)
        lightNode.categoryBitMask = 0b0001
        lightNode.lightColor = .white
        lightNode.falloff = 1.7
//        scene!.addChild(lightNode)
        
        pointing.position = CGPoint(x: 64, y: 0)
//        pointing.color = .white
        pointing.size = CGSize(width: 32, height: 10)
        pointing.physicsBody = SKPhysicsBody(rectangleOf: pointing.size)
        pointing.physicsBody?.affectedByGravity = false
        pointing.physicsBody?.contactTestBitMask = holeCategory
        pointing.physicsBody?.collisionBitMask = playerCategory
        pointing.physicsBody?.categoryBitMask = playerCategory
        let constraint = SKConstraint.distance(SKRange(lowerLimit: 50 , upperLimit: 72), to: player)
        pointing.constraints = [constraint]

        
        player.position = CGPoint(x: 0, y: 0)
        player.texture = SKTexture(imageNamed: "sphere cream.png")
        player.size = CGSize(width: 60, height: 60)
        player.physicsBody = SKPhysicsBody(circleOfRadius: 21)
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.allowsRotation = false
        
        scene!.addChild(player)
        player.addChild(lightNode)
        player.addChild(pointing)
        
        scene!.addChild(gameCamera)
        camera = gameCamera
        
         }
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        for node in self.children{
            if (node.name == "TileMap") {
                
                if let someTileMap:SKTileMapNode = node as? SKTileMapNode{
                    
                    giveTileMapPhysics(map: someTileMap)
                    someTileMap.removeFromParent()
                }
                break
            }
            
//            if (node.name == "camera1"){
//                gameCamera = (node as? SKCameraNode)!
//            }
            
        }
    }
    
    
    func giveTileMapPhysics(map: SKTileMapNode){
           
           let tilemap = map
           
           let startingLocation: CGPoint = tilemap.position
           
           let tileSize = tilemap.tileSize
           
           let halfwidth = CGFloat(tilemap.numberOfColumns) / 2 * tileSize.width
           let halfheight = CGFloat(tilemap.numberOfRows) / 2 * tileSize.height
           
           for col in 0..<tilemap.numberOfColumns{
               for row in 0..<tilemap.numberOfRows{
                   
                   if let tiledefinition = tilemap.tileDefinition(atColumn: col, row: row){
                       
                       let tileArrey = tiledefinition.textures
                       let tileTexture = tileArrey[0]
                       let x = CGFloat(col) * tileSize.width - halfwidth + (tileSize.width / 2)
                       let y = CGFloat(row) * tileSize.height - halfheight + (tileSize.height / 2)
                       
                    let tileNode = SKSpriteNode(texture: tileTexture, size: tileTexture.size())
                       tileNode.position = CGPoint(x: x, y: y)
                    
                    tileNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: (tileTexture.size().width), height: (tileTexture.size().height)))
                    
                       
                    tileNode.physicsBody?.linearDamping = 0
                       tileNode.physicsBody?.affectedByGravity = false
                       tileNode.physicsBody?.allowsRotation = false
//                       tileNode.physicsBody?.friction = 1
                       tileNode.physicsBody?.isDynamic = false
                    
                    
                    self.addChild(tileNode)
                    tileNode.lightingBitMask = 1
                    
//                    if tiledefinition.name == "wall corner dx down" || tiledefinition.name == "wall corner sx down" || tiledefinition.name == "wall centre down" || tiledefinition.name == "wall dx" || tiledefinition.name == "wall sx" || tiledefinition.name == "wall corner dx up" || tiledefinition.name == "wall corner sx up" || tiledefinition.name == "roof dx" || tiledefinition.name == "roof sx" || tiledefinition.name == "roof corner dx up" || tiledefinition.name == "roof corner sx up" || tiledefinition.name == "roof centre up"
//                    {
//                        let action =  SKAction.wait(forDuration: 1) //Try different time durations
//                        scene!.run(action, completion:
//                        {
//                            tileNode.shadowCastBitMask = 1
//
//                        })
//                    }
                    
                    
//                    print(tiledefinition.name)
                    tileNode.position = CGPoint(x: tileNode.position.x + startingLocation.x, y: tileNode.position.y + startingLocation.y)
                    
                    if tiledefinition.name == "scar up" {
                        
                        tileNode.physicsBody?.categoryBitMask = holeCategory
                        print(tileTexture)
                        tileNode.physicsBody?.contactTestBitMask = playerCategory
                        } else{
                            tileNode.physicsBody?.categoryBitMask = wallCategory

                    }
                    tileNodes.append(tileNode)
                       
                   }
               }
           }
       
       }
    
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
      
    }
    
    func touchUp(atPoint pos : CGPoint) {
       
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      move = true
        if let touch = touches.first {
            npos = touch.location(in: scene!)
          }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            npos = touch.location(in: scene!)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        move = false
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    fileprivate func showShadows() {
        for tile in tileNodes {
            let distance = CGPoint(x: (tile.position.x - player.position.x).magnitude, y: (tile.position.y - player.position.y).magnitude)
            
            if distance.x + distance.y >= 450 {
                
                tile.shadowCastBitMask = 0
                
            }else{
                tile.shadowCastBitMask = 1
                
            }
        }
    }
    
    fileprivate func playerMovement() {
        let angle = atan2((npos.y - player.position.y) , (npos.x - player.position.x))
        player.zRotation = angle
        
        let playerMove = CGPoint(x: (player.position.x + cos(angle) * 3) , y: (player.position.y + sin(angle) * 3))
        
        if move == true{
            player.position = playerMove
            
            gameCamera.position = player.position
            self.camera?.position = player.position
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
      
        playerMovement()
       
        showShadows()
       
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collisionA:UInt32 = contact.bodyA.categoryBitMask
        let collisionB:UInt32 = contact.bodyB.categoryBitMask
        
        if collisionA == playerCategory && collisionB == holeCategory {
            
            let myScene = ThirdHaptic(fileNamed: "thirdHaptic")
                           myScene?.scaleMode = .aspectFill
                           self.scene?.view?.presentScene(myScene!, transition: SKTransition.fade(withDuration: 0))
//            game.newScene(scene: "Minigame")
//            LoadScene.play()
            print("New Scene")

        }
        
    }
}

