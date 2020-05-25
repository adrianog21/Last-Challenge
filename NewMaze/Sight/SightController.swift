//
//  GameViewController.swift
//  MinigameSight
//
//  Created by Paolo Merlino on 04/05/2020.
//  Copyright © 2020 PaoloMerlino. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit


class SightController: UIViewController {
    

    
    override func viewDidLoad() {


        super.viewDidLoad()

        let scene = SightGame(size: view.bounds.size)
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
        
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    
    
}
