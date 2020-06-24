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
    let losePosition = [CGPoint(x: -1540, y: -2108), CGPoint(x: 3200, y: 2076), CGPoint(x: -2813, y: 2716)]
    // minigame position u 839,625 3069,987  d 839,625 3005,988
    // u 2492,455 -1541,457   , -1605,456
    // u -3457,322 -376,25  ,    -440,249
    
    // keys 253,801 , -2974,536      2036,803 ,  261,825      -1721,803 , 2691,973
    
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
        defaults.set(defaults.integer(forKey: "keys") + 1, forKey: "keys")
        print(defaults.integer(forKey: "keys"))
        
        if defaults.bool(forKey: "HapticKey") == true && defaults.bool(forKey: "SightKey") == true && defaults.bool(forKey: "SoundKey") == true {
                  defaults.set(true, forKey: "exit")
              }
    }
    
    mutating func getMinigame(game : String){
        print(defaults.bool(forKey: game))
        defaults.set(true, forKey: game)
        print(defaults.bool(forKey: game))
        
        if defaults.bool(forKey: "HapticGame") == true && defaults.bool(forKey: "SightGame") == true && defaults.bool(forKey: "SoundGame") == true {
            defaults.set(true, forKey: "timer")
            
                  defaults.set(14, forKey: "minutes")
                  defaults.set(60, forKey: "seconds")
            
            defaults.set(0, forKey: "keys")
        }
    }
    
    mutating func story(progress : String){
        defaults.set(true, forKey: progress)
    }
    
    mutating func newScene(scene : String){
        //LOSE
        if scene == "Lose" && defaults.bool(forKey: "FirstLose") == false{
            let random = Int.random(in: 0...2)
            lastX(xPos: Float(losePosition[random].x))
            lastY(yPos: Float(losePosition[random].y))
            defaults.set(true, forKey: "FirstLose")
            nextScene = "Story"
            defaults.set(2, forKey: "story")
        }else if scene == "Lose" && defaults.bool(forKey: "FirstLose") == true{
            let random = Int.random(in: 0...2)
            lastX(xPos: Float(losePosition[random].x))
            lastY(yPos: Float(losePosition[random].y))
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
        
        if scene == "End"{
            defaults.set(4, forKey: "keys")
            nextScene = "Story"
            defaults.set(4, forKey: "story")
        }
        
        if scene == "GameOver"{
            defaults.set(5, forKey: "story")
            nextScene = "Story"
            defaults.set(5, forKey: "story")
        }
    }
}
