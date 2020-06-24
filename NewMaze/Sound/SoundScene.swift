//
//  SoundScene.swift
//  NewMaze
//
//  Created by Martina Dinardo on 05/06/2020.
//  Copyright © 2020 Adriano Gatto. All rights reserved.
//


import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

protocol TransitionDelegate: SKSceneDelegate {
    func returnToMainMenu()
}

class SoundScene: SKScene {
    
    let rose = SKSpriteNode()
    let button = SKSpriteNode()
    var din = SKSpriteNode()
    var din2 = SKSpriteNode()
    var din3 = SKSpriteNode()
    var din4 = SKSpriteNode()
    var din5 = SKSpriteNode()
    var din6 = SKSpriteNode()
    
    var livesX = 3
    var win = 0
    
    var audioPlayer: AVAudioPlayer?
    var sound = String()
    var soundPlay = false
    
    var timer1 = Timer()
    var timer2 = Timer()
    var timer3 = Timer()
    
    var canPlay = true
    
    
    var clock = SKSpriteNode()
    
    var heart = SKSpriteNode()
    
    var npos = CGPoint()
    var newAngle = CGFloat()
    var angle = CGFloat()
    var angle2 = CGFloat()
    
    var lastpos = CGFloat()
    var soundPos = CGFloat()
    
    fileprivate func roseDesign() {
        rose.texture = SKTexture(imageNamed: "windRose")
        rose.position = .zero
        rose.size = rose.texture?.size() as! CGSize
        addChild(rose)
        soundPos = CGFloat.random(in: -179...179)
        
        button.size = CGSize(width: 70, height: 35)
        button.texture = SKTexture(imageNamed: "check")
        button.position = CGPoint(x: 290, y: -125)
        button.name = "button"
        addChild(button)
        
        din.texture = SKTexture(imageNamed: "plumbobu")
        din.size = CGSize(width: 14, height: 22)
        din.position = CGPoint(x: 0, y: 143)
        din.xScale = CGFloat(1)
        rose.addChild(din)
        
        din2.texture = SKTexture(imageNamed: "plumbobu")
        din2.size = CGSize(width: 14, height: 22)
        din2.position = CGPoint(x: 0, y: 143)
        din2.xScale = CGFloat(-1)
        rose.addChild(din2)
        
        din3.texture = SKTexture(imageNamed: "plumbobu")
        din3.size = CGSize(width: 14, height: 22)
        din3.position = CGPoint(x: 0, y: 143)
        din3.xScale = CGFloat(0.75)
        rose.addChild(din3)
        
        din4.texture = SKTexture(imageNamed: "plumbobu")
        din4.size = CGSize(width: 14, height: 22)
        din4.position = CGPoint(x: 0, y: 143)
        din4.xScale = CGFloat(0.25)
        rose.addChild(din4)
        
        din5.texture = SKTexture(imageNamed: "plumbobu")
        din5.size = CGSize(width: 14, height: 22)
        din5.position = CGPoint(x: 0, y: 143)
        din5.xScale = CGFloat(-0.25)
        rose.addChild(din5)
        
        din6.texture = SKTexture(imageNamed: "plumbobu")
        din6.size = CGSize(width: 14, height: 22)
        din6.position = CGPoint(x: 0, y: 143)
        din6.xScale = CGFloat(-0.75)
        rose.addChild(din6)
        
        clock.texture = SKTexture(imageNamed: "clock")
        clock.position = .zero
        clock.size = clock.texture?.size() as! CGSize
        addChild(clock)
        
    }
    
    override func sceneDidLoad() {
    
             let emitter = SKEmitterNode(fileNamed: "Dust")
             emitter?.position = .zero
             emitter?.advanceSimulationTime(30)
             emitter?.particleAlpha = 1
             addChild(emitter!)
        
    super.sceneDidLoad()
        
        roseDesign()
        
        heart.position = CGPoint(x: 300, y: 150)
        heart.texture = SKTexture(imageNamed: "heart")
        heart.size = CGSize(width: (heart.texture?.size().width)! * 0.7, height: (heart.texture?.size().height)! * 0.7)
        addChild(heart)
        
        let bigger = SKAction.scale(to: 1.2, duration: 0.2)
        let smaller = SKAction.scale(to: 1.1, duration: 0.1)
        let normale = SKAction.scale(to: 1, duration: 0.2)
        let wait = SKAction.wait(forDuration: 0.70)
        let animation = SKAction.sequence([bigger, smaller, bigger, normale, wait])
        let loop = SKAction.repeatForever(animation)
        heart.run(loop)
        
        
    }
    
    override func didMove(to view: SKView) {
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           if let touch = touches.first {
               npos = touch.location(in: scene!)
            angle = atan2((npos.y - 0) , (npos.x - 0))
               lastpos = rose.zRotation
//            print(lastpos)
             }
        let node = self.nodes(at: npos).first
        
        if node?.name == "button"{
        checkPosition()
            print(soundPos)
            print(newAngle)
        }
       }
       
       override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
           for touch in touches {
               npos = touch.location(in: scene!)

            angle2 = atan2((npos.y - 0) , (npos.x - 0))
            rose.zRotation = (angle2 - angle) + lastpos
//            print(rose.zRotation)
           }
       }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastpos = rose.zRotation
    }
    
    fileprivate func checkPosition() {
        
        if newAngle > soundPos - 5 && newAngle < soundPos + 5 {
            level.lastY(yPos: Float(level.getPosition().y - 30))
            soundPos = CGFloat.random(in: -175...175)
            win += 1
            
            level.defaults.set(win, forKey: "WinCount")
            
            if win == 3 {
                timer1.invalidate()
                timer2.invalidate()
                timer3.invalidate()
                audioPlayer?.stop()
            level.getMinigame(game: "SoundGame")
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
                print(soundPos)
                audioPlayer?.stop()
                soundPlay = true
            }
        } else {
            livesX -= 1

            if livesX == 0 {
                canPlay = false
                audioPlayer?.stop()
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
                audioPlayer?.stop()

            }
        }
    }
    
    fileprivate func diamante() {
        var rotation = -0.01
        
        din3.xScale += CGFloat(rotation)
        din4.xScale += CGFloat(rotation)
        din5.xScale += CGFloat(rotation)
        din6.xScale += CGFloat(rotation)
        if din3.xScale <= -1 {
            din3.xScale = 1
        }
        if din4.xScale <= -1 {
            din4.xScale = 1
        }
        if din5.xScale <= -1 {
            din5.xScale = 1
        }
        if din6.xScale <= -1 {
            din6.xScale = 1
        }
    }
    
    
    
    fileprivate func soundDirection() {
        
        if canPlay == true{
        if newAngle < soundPos - 5 && newAngle > soundPos - 180 && soundPlay == false{
            print("left")
            sound = "fast.mp3"
            soundPlay = true
            timer1 = Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(play), userInfo: nil, repeats: false)
        }else if newAngle > soundPos + 5 && newAngle < soundPos + 180 && soundPlay == false{
            print("right")
            sound = "slow.mp3"
            soundPlay = true
            timer2 = Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(play), userInfo: nil, repeats: false)
        }else if newAngle > soundPos - 5 && newAngle < soundPos + 5 && soundPlay == false {
            sound = "normal.mp3"
            soundPlay = true
            timer3 = Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(play), userInfo: nil, repeats: false)
            }
        }
    }
    
    @objc func play(){
              let music = Bundle.main.path(forResource: sound, ofType: nil)
              let url = URL(fileURLWithPath: music!)
              do {
                  self.audioPlayer = try AVAudioPlayer(contentsOf: url)
                  self.audioPlayer?.play()
                  //print("playA")
              } catch {
                  print(error)
              }
        soundPlay = false
          }
    
    override func update(_ currentTime: TimeInterval) {
        diamante()
        roseAngle()
        soundDirection()
        level.defaults.set(livesX, forKey: "SoundLives")
    }
    
    fileprivate func roseAngle() {
        newAngle = rose.zRotation * CGFloat(180/Float.pi)
        if newAngle > 180 {
            rose.zRotation -= CGFloat( 360 * (Float.pi/180))
        }
        else if newAngle < -180 {
            rose.zRotation += CGFloat( 360 * (Float.pi/180))
        }
    }
}
