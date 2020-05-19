//
//  MenuController.swift
//  NewMaze
//
//  Created by Adriano Gatto on 19/05/2020.
//  Copyright © 2020 Adriano Gatto. All rights reserved.
//

import GameKit
import UIKit
import SpriteKit

class Menu : UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
               // Load the SKScene from 'GameScene.sks'
        if let scene = SKScene(fileNamed: "MenuScene") {
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
                       // Present the scene
            view.presentScene(scene)
        
//        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(scroll), userInfo: nil, repeats: true)
    }
    
//    @objc func scroll(){
       
//
//        }
//    }
}
}
}

