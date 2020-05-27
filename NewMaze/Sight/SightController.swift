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

weak var sightController = SightController()

class SightController: UIViewController {
    

    
    override func viewDidLoad() {


        super.viewDidLoad()

        let scene = SightGame(size: view.bounds.size)
        let skView = view as! SKView
        skView.preferredFramesPerSecond = 30
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        skView.backgroundColor = .black
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
        
        
    }
    
            func newScene(scene : String) {
//                let VC = self.storyboard!.instantiateViewController(withIdentifier: scene) as! UINavigationController
//                self.navigationController?.present(VC, animated: false, completion: nil)
                _ = navigationController?.popViewController(animated: true)
                print(scene)
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
