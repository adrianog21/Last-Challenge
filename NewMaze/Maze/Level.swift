//
//  level.swift
//  NewMaze
//
//  Created by Adriano Gatto on 28/05/2020.
//  Copyright © 2020 Adriano Gatto. All rights reserved.
//

import Foundation
import GameplayKit
import UIKit
import SpriteKit

struct Level {
    var xPosition = CGFloat(0)
    var yPosition = CGFloat(0)
    let deafults = UserDefaults.standard
    
    mutating func lastX(xPos: CGFloat) {
        xPosition = CGFloat(deafults.float(forKey: "X"))
        deafults.set(xPos, forKey: "X")
    }
    
    mutating func lastY(yPos: CGFloat) {
        yPosition = CGFloat(deafults.float(forKey: "Y"))
        deafults.set(yPos, forKey: "Y")
    }
}
