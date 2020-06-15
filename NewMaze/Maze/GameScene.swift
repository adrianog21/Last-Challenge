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
       
       var sightD = CGFloat()
       var soundD = CGFloat()
       var hapticD = CGFloat()
       
       var audioPlayer: AVAudioPlayer?
       var soundAudio: AVAudioPlayer?
       var soundAudio2: AVAudioPlayer?
       
       var tileNodes = [SKSpriteNode]()
       
       var npos = CGPoint()
       var keyPosition = CGPoint()
       
       let lightNode = SKLightNode()
       let player = SKSpriteNode()
       let pointing = SKSpriteNode()
       
       let arrow = SKSpriteNode()
       let body1 = SKSpriteNode()
       let body2 = SKSpriteNode()
       let body3 = SKSpriteNode()
       let head1 = SKSpriteNode()
       let head2 = SKSpriteNode()
       let head3 = SKSpriteNode()
       
       var hapticKey = SKSpriteNode()
       var sightKey = SKSpriteNode()
       var soundKey = SKSpriteNode()
       
       var exit = SKSpriteNode()
       
       //BOOL
       var move = false
       var getHaptic = false
       var getSight = false
       
       var soundPlay = true
       var sightShow = true
       var hapticVibrate = true
       
       var point = SKNode()
       
       let gameCamera = SKCameraNode()
       
       private var lastUpdateTime : TimeInterval = 0
       private var label : SKLabelNode?
       private var spinnyNode : SKShapeNode?
    
    //Scene
        fileprivate func createPlayer() {
            lightNode.position = CGPoint(x: 0, y: 0)
            lightNode.categoryBitMask = 0b0001
            lightNode.lightColor = .white
            lightNode.falloff = 1.3
            //        scene!.addChild(lightNode)
            
            pointing.position = CGPoint(x: 0, y: 72)
            //        pointing.color = .white
            pointing.size = CGSize(width: 10, height: 35)
            pointing.physicsBody = SKPhysicsBody(rectangleOf: pointing.size)
            pointing.physicsBody?.affectedByGravity = false
            pointing.physicsBody?.contactTestBitMask = hapticCategory
            pointing.physicsBody?.collisionBitMask = playerCategory
            pointing.physicsBody?.categoryBitMask = playerCategory
            let constraint = SKConstraint.distance(SKRange(lowerLimit: 50 , upperLimit: 72), to: player)
            pointing.constraints = [constraint]
            point.zRotation = 0
            
            
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
        }
        
        fileprivate func pointingArrow() {
            body1.texture = SKTexture(imageNamed: "arrowBody")
            body1.size = body1.texture?.size() as! CGSize
            body1.position = CGPoint(x: 0, y: 100)
    //        body1.alpha = 0
            
            body2.texture = SKTexture(imageNamed: "arrowBody")
            body2.size = body1.texture?.size() as! CGSize
            body2.position = CGPoint(x: 0, y: 120)
    //        body2.alpha = 0
            
            body3.texture = SKTexture(imageNamed: "arrowBody")
            body3.size = body1.texture?.size() as! CGSize
            body3.position = CGPoint(x: 0, y: 140)
    //        body3.alpha = 0
            
            head1.texture = SKTexture(imageNamed: "arrowBody")
            head1.size = body1.texture?.size() as! CGSize
            head1.position = CGPoint(x: 15, y: 150)
            head1.zRotation = -40
    //        head1.alpha = 0
            
            head2.texture = SKTexture(imageNamed: "arrowBody")
            head2.size = body1.texture?.size() as! CGSize
            head2.position = CGPoint(x: -15, y: 150)
            head2.zRotation = 40
    //        head2.alpha = 0
            
            head3.texture = SKTexture(imageNamed: "arrowHead")
            head3.size = head3.texture?.size() as! CGSize
            head3.position = CGPoint(x: 0, y: 160)
    //        head3.alpha = 0
            arrow.alpha = 0
            
            arrow.position = CGPoint(x: 0, y: 0)
            arrow.zRotation = 0
            arrow.zPosition = 3
            arrow.addChild(body1)
            arrow.addChild(body2)
            arrow.addChild(body3)
            arrow.addChild(head1)
            arrow.addChild(head2)
            arrow.addChild(head3)
            player.addChild(arrow)
        }
        
        override func sceneDidLoad() {

            self.lastUpdateTime = 0

            createPlayer()

            pointingArrow()
            
            scene!.addChild(gameCamera)
            camera = gameCamera
            gameCamera.xScale = gameCamera.xScale * 1.9
            gameCamera.yScale = gameCamera.yScale * 1.9
            
            let emitter = SKEmitterNode(fileNamed: "Dust")
            emitter?.position = .zero
            emitter?.advanceSimulationTime(30)
            addChild(emitter!)
            
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
                    
                    if level.defaults.bool(forKey: "HapticGame") == true{
                        scar.isHidden = true
                    }else{
                        scar.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64))
                        
                        scar.physicsBody?.isDynamic = false
                        scar.lightingBitMask = 1
                        scar.physicsBody?.categoryBitMask = hapticCategory
                        scar.physicsBody?.contactTestBitMask = playerCategory
                    }
                }
            }else if node.name == "HapticDown"{
                if let scar:SKSpriteNode = node as? SKSpriteNode{
                    
                    scar.lightingBitMask = 1
                    if level.defaults.bool(forKey: "HapticGame") == true{
                        scar.isHidden = true
                    }
                }
            }
            
            if (node.name == "SightUp") {
                if let scar:SKSpriteNode = node as? SKSpriteNode{
                    
                    if level.defaults.bool(forKey: "SightGame") == true{
                        scar.isHidden = true
                    }else{
                        scar.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64))
                        
                        scar.physicsBody?.isDynamic = false
                        scar.lightingBitMask = 1
                        scar.physicsBody?.categoryBitMask = sightCategory
                        scar.physicsBody?.contactTestBitMask = playerCategory
                    }
                }
            }else if node.name == "SightDown"{
                if let scar:SKSpriteNode = node as? SKSpriteNode{
                    
                    scar.lightingBitMask = 1
                    if level.defaults.bool(forKey: "SightGame") == true{
                        scar.isHidden = true
                    }
                }
            }
            
            if (node.name == "SoundUp") {
                if let scar:SKSpriteNode = node as? SKSpriteNode{
                    
                    if level.defaults.bool(forKey: "SoundGame") == true{
                        scar.isHidden = true
                    }else{
                        scar.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64))
                        
                        scar.physicsBody?.isDynamic = false
                        scar.lightingBitMask = 1
                        scar.physicsBody?.categoryBitMask = soundCategory
                        scar.physicsBody?.contactTestBitMask = playerCategory
                    }
                }
            }else if node.name == "SoundDown"{
                if let scar:SKSpriteNode = node as? SKSpriteNode{
                    
                    scar.lightingBitMask = 1
                    if level.defaults.bool(forKey: "SoundGame") == true{
                        scar.isHidden = true
                    }
                }
            }
            
            if node.name == "Exit"{
                if let door:SKSpriteNode = node as? SKSpriteNode{
                    
                    exit = door
                    exit.lightingBitMask = 1
                    exit.zPosition = 15
                    if level.defaults.bool(forKey: "timer") == true {
                        exit.isHidden = false
                        exit.alpha = 0
                    }
                    if level.defaults.bool(forKey: "exit") == true{
                        exit.isHidden = false
                        print("1")
                    }else{
                        exit.isHidden = true
                        print("11")

                    }
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
                    keyPosition = sk.position
                   
                }
            }
            if node.name == "SoundKey"{
                if let ak:SKSpriteNode = node as? SKSpriteNode{
                    soundKey = ak
                    soundKey.position = ak.position
                   
                }
            }
            
        }
        showKeys()
        
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
                                tileNode.physicsBody?.categoryBitMask = self.wallCategory
                              
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
    
//    fileprivate func keyTouch() {
//
//        let hapticX = hapticKey.position.x.magnitude - npos.x.magnitude
//        let haptixY = hapticKey.position.y.magnitude - npos.y.magnitude
//
//        let haptic2X = hapticKey.position.x.magnitude - player.position.x.magnitude
//        let haptic2Y = hapticKey.position.y.magnitude - player.position.y.magnitude
//
//        if hapticX.magnitude + haptixY.magnitude < 100 && haptic2X.magnitude + haptic2Y.magnitude < 200{
////            hapticKey.alpha = 0
//            print("HK")
//            level.getKey(key: "HapticKey")
//            showKeys()
//        }
//
//        let sightX = sightKey.position.x.magnitude - npos.x.magnitude
//        let sightY = sightKey.position.y.magnitude - npos.y.magnitude
//
//        let sight2X = sightKey.position.x.magnitude - player.position.x.magnitude
//        let sight2Y = sightKey.position.y.magnitude - player.position.y.magnitude
//
//        if sightX.magnitude + sightY.magnitude < 100 && sight2X.magnitude + sight2Y.magnitude < 200{
////            sightKey.alpha = 0
//            print("SK")
//            level.getKey(key: "SightKey")
//            showKeys()
//        }
//
//        let soundX = soundKey.position.x.magnitude - npos.x.magnitude
//        let soundY = soundKey.position.y.magnitude - npos.y.magnitude
//
//        let sound2X = soundKey.position.x.magnitude - player.position.x.magnitude
//        let sound2Y = soundKey.position.y.magnitude - player.position.y.magnitude
//
//        if soundX.magnitude + soundY.magnitude < 100 && sound2X.magnitude + sound2Y.magnitude < 200{
//            //            sightKey.alpha = 0
//            print("AK")
//            level.getKey(key: "SoundKey")
//            showKeys()
//        }
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            npos = touch.location(in: scene!)
            
 //           keyTouch()
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
    
       fileprivate func searchKeys() {
            let soundX = soundKey.position.x - player.position.x
            let soundY = soundKey.position.y - player.position.y
            soundD = soundX.magnitude + soundY.magnitude
            
            let hapticX = hapticKey.position.x - player.position.x
            let hapticY = hapticKey.position.y - player.position.y
            hapticD = hapticX.magnitude + hapticY.magnitude
            
            let sightX = sightKey.position.x.magnitude - player.position.x.magnitude
            let sightY = sightKey.position.y.magnitude - player.position.y.magnitude
            sightD = sightX.magnitude + sightY.magnitude
            
            if level.defaults.bool(forKey: "HapticKey") == false{
            if hapticD < 1500 && hapticVibrate == true {
                _ = Timer.scheduledTimer(timeInterval: TimeInterval(hapticD / 500), target: self, selector: #selector(vibrate), userInfo: nil, repeats: false)
                hapticVibrate = false
                
                if hapticD < 50{
                    level.getKey(key: "HapticKey")
                    showKeys()
                    let music = Bundle.main.path(forResource: "01.wav", ofType: nil)
                    let url = URL(fileURLWithPath: music!)
                    do {
                        self.soundAudio = try AVAudioPlayer(contentsOf: url)
                        self.soundAudio?.play()
                        //print("playA")
                    } catch {
                        print(error)
                    }
                    let impact = UIImpactFeedbackGenerator()
                    impact.impactOccurred(intensity: 10)
                    if level.defaults.bool(forKey: "exit") == true{
                        exit.isHidden = false
                    }
                }
                }
            }
            if level.defaults.bool(forKey: "SightKey") == false{
            if sightD < 1500 && sightShow == true {
               _ = Timer.scheduledTimer(timeInterval: TimeInterval(sightD / 500), target: self, selector: #selector(show), userInfo: nil, repeats: false)
               sightShow = false
                
                if sightD < 50{
                    level.getKey(key: "SightKey")
                    showKeys()
                    let music = Bundle.main.path(forResource: "01.wav", ofType: nil)
                    let url = URL(fileURLWithPath: music!)
                    do {
                        self.soundAudio = try AVAudioPlayer(contentsOf: url)
                        self.soundAudio?.play()
                        //print("playA")
                    } catch {
                        print(error)
                    }
                    let impact = UIImpactFeedbackGenerator()
                    impact.impactOccurred(intensity: 10)
                    if level.defaults.bool(forKey: "exit") == true{
                        exit.isHidden = false
                    }
                }
            }
            }
            if level.defaults.bool(forKey: "SoundKey") == false{
            if soundD < 1500 && soundPlay == true{
                _ = Timer.scheduledTimer(timeInterval: TimeInterval(soundD / 500), target: self, selector: #selector(play), userInfo: nil, repeats: false)
                soundPlay = false
                
                if soundD < 50{
                    level.getKey(key: "SoundKey")
                    showKeys()
                    let music = Bundle.main.path(forResource: "01.wav", ofType: nil)
                               let url = URL(fileURLWithPath: music!)
                               do {
                                   self.soundAudio = try AVAudioPlayer(contentsOf: url)
                                   self.soundAudio?.play()
                                   //print("playA")
                               } catch {
                                   print(error)
                               }
                    let impact = UIImpactFeedbackGenerator()
                    impact.impactOccurred(intensity: 10)
                    if level.defaults.bool(forKey: "exit") == true{
                        exit.isHidden = false
                    }
                }
            }
            }
        }
        
        @objc func vibrate(){
            let impact = UIImpactFeedbackGenerator()
            impact.impactOccurred(intensity: 10)
    //        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            hapticVibrate = true
        }
        
        @objc func show(){
            
            
            let angleArrow = atan2((keyPosition.y - player.position.y) , (keyPosition.x - player.position.x))
            arrow.zRotation = angleArrow - 1.5708
            
            let wait = sightD / 3000
    //
    //        let n1 = SKAction.sequence([SKAction.wait(forDuration: TimeInterval(wait)), SKAction.fadeIn(withDuration: TimeInterval(0.1)), SKAction.wait(forDuration: TimeInterval(wait * 5)), SKAction.fadeOut(withDuration: TimeInterval(0.1))])
            
            let n1 = SKAction.sequence([SKAction.fadeIn(withDuration: TimeInterval(wait)), SKAction.wait(forDuration: TimeInterval(wait)), SKAction.fadeOut(withDuration: TimeInterval(wait))])
            arrow.run(n1)
    //
    //        let n2 = SKAction.sequence([SKAction.wait(forDuration: TimeInterval(wait * 2)), SKAction.fadeIn(withDuration: TimeInterval(0.1)), SKAction.wait(forDuration: TimeInterval(wait * 5)), SKAction.fadeOut(withDuration: TimeInterval(0.1))])
    //        body2.run(n2)
    //
    //        let n3 = SKAction.sequence([SKAction.wait(forDuration: TimeInterval(wait * 3)), SKAction.fadeIn(withDuration: TimeInterval(0.1)), SKAction.wait(forDuration: TimeInterval(wait * 5)), SKAction.fadeOut(withDuration: TimeInterval(0.1))])
    //        body3.run(n3)
    //
    //        let n4 = SKAction.sequence([SKAction.wait(forDuration: TimeInterval(wait * 4)), SKAction.fadeIn(withDuration: TimeInterval(0.1)), SKAction.wait(forDuration: TimeInterval(wait * 5)), SKAction.fadeOut(withDuration: TimeInterval(0.1))])
    //        head1.run(n4)
    //        head2.run(n4)
    //
    //        let n6 = SKAction.sequence([SKAction.wait(forDuration: TimeInterval(wait * 5)), SKAction.fadeIn(withDuration: TimeInterval(0.1)), SKAction.wait(forDuration: TimeInterval(wait * 5)), SKAction.fadeOut(withDuration: TimeInterval(0.1))])
    //        head3.run(n6)
    //
    //
            sightShow = true
        }
        
        @objc func play(){
            let music = Bundle.main.path(forResource: "beep.mp3", ofType: nil)
            let url = URL(fileURLWithPath: music!)
            do {
                self.soundAudio2 = try AVAudioPlayer(contentsOf: url)
                self.soundAudio2?.play()
                //print("playA")
                self.soundPlay = false
            } catch {
                print(error)
            }
            soundPlay = true
        }
        
        override func update(_ currentTime: TimeInterval) {
          
            playerMovement()
           
            showShadows()
                    
            if level.defaults.bool(forKey: "timer") == true {

                searchKeys()
                if level.defaults.bool(forKey: "exit") == true{
                    exit.isHidden = false
                    exit.run(SKAction.fadeIn(withDuration: 1))
                    print("aaa")
                }
            }
        }
    
    func showKeys(){
        
        if level.defaults.bool(forKey: "timer") == true {
                   if level.defaults.bool(forKey: "SightKey") == true{
                       sightKey.isHidden = true
                   }else{ sightKey.isHidden = false}
                   
                   if level.defaults.bool(forKey: "HapticKey") == true{
                       hapticKey.isHidden = true
                   }else{ hapticKey.isHidden = false}
                   
                   if level.defaults.bool(forKey: "SoundKey") == true{
                       soundKey.isHidden = true
                   }else{ soundKey.isHidden = false}
               }else {
                   hapticKey.isHidden = true
                   soundKey.isHidden = true
                   sightKey.isHidden = true
               }
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
            level.lastY(yPos: Float(player.position.y - 40))

            gamecontroller?.newScene(scene: "Haptic")
            
            print("New Scene")
            
            enterAudio()
        }
        if collisionA == playerCategory && collisionB == sightCategory {
            level.lastY(yPos: Float(player.position.y - 40))

            gamecontroller?.newScene(scene: "Sight")
            
            print("New Scene")
            
            enterAudio()
        }
        if collisionA == playerCategory && collisionB == soundCategory {
            level.lastY(yPos: Float(player.position.y - 40))

            gamecontroller?.newScene(scene: "Sound")
            
            print("New Scene")
            
            enterAudio()
        }
        
    }
}

