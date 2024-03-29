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
    
    @IBOutlet weak var newGame: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newGame.alpha = 0

        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "MenuScene") {
                
                
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill

                // Present the scene
                view.presentScene(scene)
            }

            view.ignoresSiblingOrder = true

            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        newGame.alpha = 0
        
    }
    
    @IBAction func newPlay(_ sender: Any) {
        newGame.alpha = 1
    }
    
    
    @IBAction func reset(_ sender: Any) {
        level.resetData()
        
        level.newScene(scene: "Play")
        
        let VC = self.storyboard!.instantiateViewController(withIdentifier: level.nextScene) as! UINavigationController
        self.navigationController?.present(VC, animated: false, completion: nil)
        print(level.nextScene)
    }
    
    @IBAction func play(_ sender: Any) {
        level.newScene(scene: "Play")
        
        let VC = self.storyboard!.instantiateViewController(withIdentifier: level.nextScene) as! UINavigationController
        self.navigationController?.present(VC, animated: false, completion: nil)
        print(level.nextScene)
    }
    

    }

