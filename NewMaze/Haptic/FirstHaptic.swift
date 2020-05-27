//
//  FirstHaptic.swift
//  NewMaze
//
//  Created by Francesco Improta on 18/05/2020.
//  Copyright © 2020 Adriano Gatto. All rights reserved.
//

import SpriteKit

import AVFoundation

class FirstHaptic: SKScene {
    
    let impact = UIImpactFeedbackGenerator()
    
    
    
   
   override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
           if let touch = touches.first{
               let location = touch.previousLocation(in: self)
               let node = self.nodes(at: location).first
               
               if node?.name == "letter"{
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
               
               if nodesArray.first?.name == "secondButton" {
                
                let myScene = SecondHaptic(fileNamed: "SecondHaptic")
                myScene?.scaleMode = .aspectFill
                self.scene?.view?.presentScene(myScene!, transition: SKTransition.fade(withDuration: 0))
//                   self.view?.presentScene(SKScene(fileNamed:"secondScene"))
                

               }
               
               if nodesArray.first?.name == "thirdButton" {
                   let myScene = ThirdHaptic(fileNamed: "ThirdHaptic")
                   myScene?.scaleMode = .aspectFill
                self.scene?.view?.presentScene(myScene!, transition: SKTransition.fade(withDuration: 0))
                
            }
            
            if nodesArray.first?.name == "fourthButton" {
            let myScene = FourthHaptic(fileNamed: "FourthHaptic")
            myScene?.scaleMode = .aspectFill
                self.scene?.view?.presentScene(myScene!, transition: SKTransition.fade(withDuration: 0))               }
           }
       }
    
    
}
