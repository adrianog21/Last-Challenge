//
//  Level.swift
//  NewMaze
//
//  Created by Adriano Gatto on 29/05/2020.
//  Copyright © 2020 Adriano Gatto. All rights reserved.
//

import Foundation
import GameplayKit
import UIKit
import SpriteKit

var level = Level()

struct Level {
    var nextScene = ""

    var xPosition = Float()
    var yPosition = Float()
//    var sightKey = false
//    var hapticKaey = false
    var defaults = UserDefaults.standard
    
    init() {
        defaults.bool(forKey: "SightKey")
        defaults.bool(forKey: "HapticKey")
        defaults.bool(forKey: "SightGame")
        defaults.bool(forKey: "HapticGame")
        
        defaults.bool(forKey: "FirstPlay")
        defaults.bool(forKey: "FirstWin")
        defaults.bool(forKey: "FirstLose")
        defaults.bool(forKey: "Allgames")
    }
    
    mutating func lastX(xPos: Float) {
//        xPosition = deafults.float(forKey: "X")
        defaults.set(xPos, forKey: "X")
//        print(xPosition)
    }
    
    mutating func lastY(yPos: Float) {
//        yPosition = deafults.float(forKey: "Y")
        defaults.set(yPos, forKey: "Y")
//        print(yPosition)
    }
    
    mutating func getPosition() -> CGPoint{
        yPosition = defaults.float(forKey: "Y")
        xPosition = defaults.float(forKey: "X")

        let newPos = CGPoint(x: CGFloat(xPosition), y: CGFloat(yPosition))
        return newPos
    }
    
    mutating func resetData() {
        UserDefaults.resetStandardUserDefaults()
        defaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        print("reset")
        print(defaults.bool(forKey: "FirstPlay"))
    }
    
    mutating func getKey(key : String){
        print(defaults.bool(forKey: key))
        defaults.set(true, forKey: key)
        print(defaults.bool(forKey: key))
    }
    
    mutating func getMinigame(game : String){
        print(defaults.bool(forKey: game))
        defaults.set(true, forKey: game)
        print(defaults.bool(forKey: game))
        
        if defaults.bool(forKey: "HapticGame") == true && defaults.bool(forKey: "SightGame") == true && defaults.bool(forKey: "SoundGame") == true {
            defaults.set(true, forKey: "timer")
        }
    }
    
    mutating func story(progress : String){
        defaults.set(true, forKey: progress)
    }
    
    mutating func newScene(scene : String){
        //LOSE
        if scene == "Lose" && defaults.bool(forKey: "FirstLose") == false{
            defaults.set(true, forKey: "FirstLose")
            nextScene = "Story"
            defaults.set(2, forKey: "story")
        }else if scene == "Lose" && defaults.bool(forKey: "FirstLose") == true{
            nextScene = "MazeGame"
        }
        //PLAY
        if scene == "Play" && defaults.bool(forKey: "FirstPlay") == false{
                   defaults.set(true, forKey: "FirstPlay")
                   nextScene = "Story"
            defaults.set(0, forKey: "story")
//            print(nextScene)
               }else if scene == "Play" && defaults.bool(forKey: "FirstPlay") == true{
                   nextScene = "MazeGame"
            
               }
        //WIN
             if scene == "Win" && defaults.bool(forKey: "FirstWin") == false{
                 defaults.set(true, forKey: "FirstWin")
                 nextScene = "Story"
                defaults.set(1, forKey: "story")
             }else if scene == "Win" && defaults.bool(forKey: "FirstWin") == true && defaults.bool(forKey: "timer") == true{
                 nextScene = "Story"
                defaults.set(3, forKey: "story")
             }
             else if scene == "Win" && defaults.bool(forKey: "FirstWin") == true && defaults.bool(forKey: "timer") == false {
                nextScene = "MazeGame"
        }
//        print(scene)
//        print(defaults.bool(forKey: "FirstPlay"))
//        print(nextScene)
//        return nextScene
    }
}
