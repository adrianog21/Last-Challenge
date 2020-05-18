//
//  SecondHaptic.swift
//  NewMaze
//
//  Created by Francesco Improta on 18/05/2020.
//  Copyright © 2020 Adriano Gatto. All rights reserved.
//


import SpriteKit

import AVFoundation

class SecondHaptic: SKScene {
    
    let impact = UIImpactFeedbackGenerator()
    
    
    
   override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
           if let touch = touches.first{
               let location = touch.previousLocation(in: self)
               let node = self.nodes(at: location).first
               
               if node?.name == "letter"
               {
                   print("ok")
   
                   impact.impactOccurred(intensity: 10)
                   print(AudioServicesPlaySystemSound(kSystemSoundID_Vibrate))
               }
           }
       }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
               
               let touch = touches.first
               
               if let location = touch?.location(in: self) {
                   let nodesArray = self.nodes(at: location)
                   
                   if nodesArray.first?.name == "fourthButton" {
    //                let transition = SKTransition.reveal(with: .down, duration: 0)
    //                   let secondscene = SKScene(size: self.size)
                       let myScene = FourthHaptic(fileNamed: "fourthHaptic")
                       myScene?.scaleMode = .aspectFill
                       self.scene?.view?.presentScene(myScene!, transition: SKTransition.fade(withDuration: 0))
                    

                   }
                   
                   if nodesArray.first?.name == "thirdButton" {
                       let myScene = ThirdHaptic(fileNamed: "thirdHaptic")
                       myScene?.scaleMode = .aspectFill
                       self.scene?.view?.presentScene(myScene!, transition: SKTransition.fade(withDuration: 0))               }
                
                if nodesArray.first?.name == "firstButton" {
                    
                    let myScene = FirstHaptic(fileNamed: "firstHaptic")
                    myScene?.scaleMode = .aspectFill
                    self.scene?.view?.presentScene(myScene!, transition: SKTransition.fade(withDuration: 0))
//                self.view?.presentScene(SKScene(fileNamed:"firstScene"))               }
               }
           }
}
}
