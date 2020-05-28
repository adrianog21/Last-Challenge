//
//  Level.swift
//  NewMaze
//
//  Created by Adriano Gatto on 28/05/2020.
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
    var defaults = UserDefaults.standard
    
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
}
