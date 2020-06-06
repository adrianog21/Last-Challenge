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
    let soundCategory:UInt32 = 0x1 << 8
    
    let velocity = CGFloat(7.5)
    
    var audioPlayer: AVAudioPlayer?
    
    var tileNodes = [SKSpriteNode]()
    
    var npos = CGPoint()
    
    let lightNode = SKLightNode()
    let player = SKSpriteNode()
    let pointing = SKSpriteNode()
    
    var hapticKey = SKSpriteNode()
    var sightKey = SKSpriteNode()
    var soundKey = SKSpriteNode()
    
    
    var move = false
    var getHaptic = false
    var getSight = false
    
    var point = SKNode()
    
    let gameCamera = SKCameraNode()
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    //Scene
    override func sceneDidLoad() {

        self.lastUpdateTime = 0

        lightNode.position = CGPoint(x: 0, y: 0)
        lightNode.categoryBitMask = 0b0001
        lightNode.lightColor = .white
        lightNode.falloff = 1.3
//        scene!.addChild(lightNode)
        
        pointing.position = CGPoint(x: 0, y: 64)
//        pointing.color = .white
        pointing.size = CGSize(width: 10, height: 35)
        pointing.physicsBody = SKPhysicsBody(rectangleOf: pointing.size)
        pointing.physicsBody?.affectedByGravity = false
        pointing.physicsBody?.contactTestBitMask = hapticCategory
        pointing.physicsBody?.collisionBitMask = playerCategory
        pointing.physicsBody?.categoryBitMask = playerCategory
        let constraint = SKConstraint.distance(SKRange(lowerLimit: 50 , upperLimit: 72), to: player)
        pointing.constraints = [constraint]

        
        player.texture = SKTexture(imageNamed: "sphere cream.png")
//        player.size = CGSize(width: 80, height: 80)
        player.physicsBody = SKPhysicsBody(circleOfRadius: 25)
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.allowsRotation = false
        
        var textures:[SKTexture] = []
        for i in 1...5 {
            textures.append(SKTexture(imageNamed: "player\(i)"))
        }
        textures.append(textures[3])
        textures.append(textures[2])
        textures.append(textures[1])
        
        let playerAnimation = SKAction.animate(with: textures, timePerFrame: 0.1)
//        let rotatePlayer = SKAction.rotate(byAngle: 90, duration: 1)
        
        scene!.addChild(player)
        player.addChild(lightNode)
        player.addChild(pointing)
        player.run(SKAction.repeatForever(playerAnimation))
//        player.run(SKAction.repeatForever(rotatePlayer))
        
        scene!.addChild(gameCamera)
        camera = gameCamera
        gameCamera.xScale = gameCamera.xScale * 1.9
        gameCamera.yScale = gameCamera.yScale * 1.9
        
        let emitter = SKEmitterNode(fileNamed: "Dust")
        emitter?.position = .zero
        emitter?.advanceSimulationTime(30)
        addChild(emitter!)
        
        showKeys()

        
         }
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        player.position = level.getPosition()
        
        //PLAY MUSIC
        let music = Bundle.main.path(forResource: "unsecure.mp3", ofType: nil)
        let url = URL(fileURLWithPath: music!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1
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
            
            if (node.name == "SoundUp") {
                if let scar:SKSpriteNode = node as? SKSpriteNode{
                    
                    scar.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64))
                    
                    scar.physicsBody?.isDynamic = false
                    scar.lightingBitMask = 1
                    scar.physicsBody?.categoryBitMask = soundCategory
                    scar.physicsBody?.contactTestBitMask = playerCategory
                }
            }else if node.name == "SoundDown"{
                if let scar:SKSpriteNode = node as? SKSpriteNode{
                    
                    scar.lightingBitMask = 1
                    
                }
            }
            
            if node.name == "HapticKey"{
                if let hk:SKSpriteNode = node as? SKSpriteNode{
                    hapticKey = hk
                    hapticKey.position = hk.position
                   
                }
            }
            if node.name == "SightKey"{
                if let sk:SKSpriteNode = node as? SKSpriteNode{
                    sightKey = sk
                    sightKey.position = sk.position
                   
                }
            }
            if node.name == "SoundKey"{
                if let ak:SKSpriteNode = node as? SKSpriteNode{
                    soundKey = ak
                    soundKey.position = ak.position
                   
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
    
    fileprivate func keyTouch() {
        
        let hapticX = hapticKey.position.x.magnitude - npos.x.magnitude
        let haptixY = hapticKey.position.y.magnitude - npos.y.magnitude
        
        let haptic2X = hapticKey.position.x.magnitude - player.position.x.magnitude
        let haptic2Y = hapticKey.position.y.magnitude - player.position.y.magnitude
        
        if hapticX.magnitude + haptixY.magnitude < 100 && haptic2X.magnitude + haptic2Y.magnitude < 200{
//            hapticKey.alpha = 0
            print("HK")
            level.getKey(key: "HapticKey")
            showKeys()
        }
        
        let sightX = sightKey.position.x.magnitude - npos.x.magnitude
        let sightY = sightKey.position.y.magnitude - npos.y.magnitude
        
        let sight2X = sightKey.position.x.magnitude - player.position.x.magnitude
        let sight2Y = sightKey.position.y.magnitude - player.position.y.magnitude
        
        if sightX.magnitude + sightY.magnitude < 100 && sight2X.magnitude + sight2Y.magnitude < 200{
//            sightKey.alpha = 0
            print("SK")
            level.getKey(key: "SightKey")
            showKeys()
        }
        
        let soundX = soundKey.position.x.magnitude - npos.x.magnitude
        let soundY = soundKey.position.y.magnitude - npos.y.magnitude
        
        let sound2X = soundKey.position.x.magnitude - player.position.x.magnitude
        let sound2Y = soundKey.position.y.magnitude - player.position.y.magnitude
        
        if soundX.magnitude + soundY.magnitude < 100 && sound2X.magnitude + sound2Y.magnitude < 200{
            //            sightKey.alpha = 0
            print("AK")
            level.getKey(key: "SoundKey")
            showKeys()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            npos = touch.location(in: scene!)
            
            keyTouch()
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
//        player.zRotation = angle
        let newSize = player.texture?.size() as! CGSize
        player.size = CGSize(width: newSize.width/2, height: newSize.height/2)
        
        let playerMove = CGPoint(x: (player.position.x + cos(angle) * velocity) , y: (player.position.y + sin(angle) * velocity))

        gameCamera.position = player.position
        self.camera?.position = player.position
        
        if move == true{
            player.position = playerMove

            level.lastY(yPos: Float(player.position.y))
            level.lastX(xPos: Float(player.position.x))
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
      
        playerMovement()
       
        showShadows()
                
    }
    
    func showKeys(){
//        if level.defaults.bool(forKey: "SightKey") == true || level.defaults.bool(forKey: "SightGame") == false {
//            sightKey.isHidden = true
//        }
//
//        if level.defaults.bool(forKey: "HapticKey") == true || level.defaults.bool(forKey: "HapticGame") == false {
//            hapticKey.isHidden = true
//        }
//
//        if level.defaults.bool(forKey: "SoundKey") == true || level.defaults.bool(forKey: "SoundGame") == false {
//                   soundKey.isHidden = true
//               }
        if level.defaults.bool(forKey: "timer") == true {
            if level.defaults.bool(forKey: "SightKey") == true{
                sightKey.isHidden = true
            }
            
            if level.defaults.bool(forKey: "HapticKey") == true{
                hapticKey.isHidden = true
            }
            
            if level.defaults.bool(forKey: "SoundKey") == true{
                soundKey.isHidden = true
            }
        }else {
            hapticKey.isHidden = true
            soundKey.isHidden = true
            sightKey.isHidden = true
        }
               
//        if level.defaults.bool(forKey: "timer") == true{
//            soundKey.isHidden = false
//            sightKey.isHidden = false
//            hapticKey.isHidden = false
//        }else{
//            hapticKey.isHidden = true
//            sightKey.isHidden = true
//            soundKey.isHidden = true
//        }
        
    }
    
    fileprivate func enterAudio() {
        let music = Bundle.main.path(forResource: "enter.mp3", ofType: nil)
        let url = URL(fileURLWithPath: music!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
            
        } catch {
            print(error)
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collisionA:UInt32 = contact.bodyA.categoryBitMask
        let collisionB:UInt32 = contact.bodyB.categoryBitMask
        
        if collisionA == playerCategory && collisionB == hapticCategory {
            level.lastY(yPos: Float(player.position.y - 30))

            gamecontroller?.newScene(scene: "Haptic")
            
            print("New Scene")
            
            enterAudio()
        }
        if collisionA == playerCategory && collisionB == sightCategory {
            level.lastY(yPos: Float(player.position.y - 30))

            gamecontroller?.newScene(scene: "Sight")
            
            print("New Scene")
            
            enterAudio()
        }
        if collisionA == playerCategory && collisionB == soundCategory {
            level.lastY(yPos: Float(player.position.y - 30))

            gamecontroller?.newScene(scene: "Sound")
            
            print("New Scene")
            
            enterAudio()
        }
        
    }
}

