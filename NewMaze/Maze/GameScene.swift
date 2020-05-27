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
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let hapticCategory:UInt32 = 0x1 << 0
    let playerCategory:UInt32 = 0x1 << 1
    let wallCategory:UInt32 = 0x1 << 2
    let sightCategory:UInt32 = 0x1 << 4
    
    let velocity = CGFloat(7.5)
    
    var audioPlayer: AVAudioPlayer?
    
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
        lightNode.falloff = 1.3
//        scene!.addChild(lightNode)
        
        pointing.position = CGPoint(x: 64, y: 0)
//        pointing.color = .white
        pointing.size = CGSize(width: 32, height: 10)
        pointing.physicsBody = SKPhysicsBody(rectangleOf: pointing.size)
        pointing.physicsBody?.affectedByGravity = false
        pointing.physicsBody?.contactTestBitMask = hapticCategory
        pointing.physicsBody?.collisionBitMask = playerCategory
        pointing.physicsBody?.categoryBitMask = playerCategory
        let constraint = SKConstraint.distance(SKRange(lowerLimit: 50 , upperLimit: 72), to: player)
        pointing.constraints = [constraint]

        
        player.position = CGPoint(x: 0, y: 0)
        player.texture = SKTexture(imageNamed: "sphere cream.png")
        player.size = CGSize(width: 80, height: 80)
        player.physicsBody = SKPhysicsBody(circleOfRadius: 25)
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.allowsRotation = false
        
        scene!.addChild(player)
        player.addChild(lightNode)
        player.addChild(pointing)
        
        scene!.addChild(gameCamera)
        camera = gameCamera
        gameCamera.xScale = gameCamera.xScale * 1.8
        gameCamera.yScale = gameCamera.yScale * 1.8
        
        let emitter = SKEmitterNode(fileNamed: "Dust")
        emitter?.position = .zero
        emitter?.advanceSimulationTime(30)
        addChild(emitter!)
        
         }
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        let music = Bundle.main.path(forResource: "unsecure.mp3", ofType: nil)
               let url = URL(fileURLWithPath: music!)
               do {
                   audioPlayer = try AVAudioPlayer(contentsOf: url)
                               audioPlayer?.play()
                   
               } catch {
                   print(error)
               }
        
        for node in self.children{
            if (node.name == "TileMap") {
                
                if let someTileMap:SKTileMapNode = node as? SKTileMapNode{
                    
                    giveTileMapPhysics(map: someTileMap)
                    someTileMap.removeFromParent()
                }
//                break
            }
            
            if (node.name == "HapticUp") {
                if let scar:SKSpriteNode = node as? SKSpriteNode{
                    
                    scar.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64))
                    
                    scar.physicsBody?.isDynamic = false
                    scar.lightingBitMask = 1
                    scar.physicsBody?.categoryBitMask = hapticCategory
                    scar.physicsBody?.contactTestBitMask = playerCategory
                }
            }else if node.name == "HapticDown"{
                if let scar:SKSpriteNode = node as? SKSpriteNode{
                    
                    scar.lightingBitMask = 1
                    
                }
            }
            
            if (node.name == "SightUp") {
                           if let scar:SKSpriteNode = node as? SKSpriteNode{
                               
                               scar.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64))
                               
                               scar.physicsBody?.isDynamic = false
                               scar.lightingBitMask = 1
                               scar.physicsBody?.categoryBitMask = sightCategory
                               scar.physicsBody?.contactTestBitMask = playerCategory
                           }
                       }else if node.name == "SightDown"{
                           if let scar:SKSpriteNode = node as? SKSpriteNode{
                               
                               scar.lightingBitMask = 1
                               
                           }
                       }
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
                    
                    
                    
                    
                    self.addChild(tileNode)
                    
                    if tiledefinition.name == "black center"
                    {
                        tileNode.lightingBitMask = 0

                    }
                    else if tiledefinition.name == "corner dx down" || tiledefinition.name == "corner dx up" || tiledefinition.name == "corner sx down" || tiledefinition.name == "corner sx up"
                    {
                        
                        let action =  SKAction.wait(forDuration: 0.1) //Try different time durations
                        scene!.run(action, completion:
                            {
                                tileNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: (tileTexture.size().width), height: (tileTexture.size().height)))
                              
                                tileNode.physicsBody?.isDynamic = false
                                tileNode.lightingBitMask = 1
                                
                                
                                tileNode.shadowCastBitMask = 1
                                
                                
                        })
                    }
                    else{
                        
                        tileNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: (tileTexture.size().width), height: (tileTexture.size().height)))
                        
                        tileNode.physicsBody?.isDynamic = false
                        tileNode.lightingBitMask = 1
                }
                    
//                    print(tiledefinition.name)
                    tileNode.position = CGPoint(x: tileNode.position.x + startingLocation.x, y: tileNode.position.y + startingLocation.y)
                    
//                    if tiledefinition.name == "scar up" {
//                        
//                        tileNode.physicsBody?.categoryBitMask = holeCategory
//                        print(tileTexture)
//                        tileNode.physicsBody?.contactTestBitMask = playerCategory
//                        } else{
                            tileNode.physicsBody?.categoryBitMask = wallCategory
//
//                    }
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
        if let touch = touches.first {
            npos = touch.location(in: scene!)
          }
        move = true
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
            
            if distance.x + distance.y >= 900 {

                let action =  SKAction.wait(forDuration: 0.05) //Try different time durations
                scene!.run(action, completion:
                {
                    tile.isHidden = true

                })
            }else{
                
                let action =  SKAction.wait(forDuration: 0.2) //Try different time durations
                scene!.run(action, completion:
                {
                    tile.isHidden = false

                })
            }
        }
    }
    
    fileprivate func playerMovement() {
        let angle = atan2((npos.y - player.position.y) , (npos.x - player.position.x))
        player.zRotation = angle
        
        let playerMove = CGPoint(x: (player.position.x + cos(angle) * velocity) , y: (player.position.y + sin(angle) * velocity))
        
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
        
        if collisionA == playerCategory && collisionB == hapticCategory {

            gamecontroller?.newScene(scene: "Haptic")
            
            print("New Scene")

        }
        if collisionA == playerCategory && collisionB == sightCategory {

            gamecontroller?.newScene(scene: "Sight")
            
            print("New Scene")

        }
        
    }
}

