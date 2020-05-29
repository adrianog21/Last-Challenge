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
    var xPosition = Float()
    var yPosition = Float()
//    var sightKey = false
//    var hapticKaey = false
    var defaults = UserDefaults.standard
    
//    init() {
//        defaults.set(sightKey, forKey: "SightKey")
//        defaults.set(hapticKaey, forKey: "HapticKey")
//    }
    
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
    }
    
    mutating func getKey(key : String){
        print(defaults.bool(forKey: "HapticKey"))
        defaults.set(true, forKey: key)
        print(defaults.bool(forKey: "HapticKey"))
    }
    
    mutating func getMinigame(game : String){
        defaults.set(true, forKey: game)
    }
}
