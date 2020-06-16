//
//  SightController.swift
//  NewMaze
//
//  Created by Francesco Improta on 13/06/2020.
//  Copyright © 2020 Adriano Gatto. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit


class SightController: UIViewController, TransitionDelegate {
    func returnToMainMenu() {
                
                let VC = self.storyboard!.instantiateViewController(withIdentifier: level.nextScene) as! UINavigationController
                self.navigationController?.present(VC, animated: false, completion: nil)
    }
    
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var explainView: UIImageView!
    var count = 0
    let images = [#imageLiteral(resourceName: "sight 1.pdf"), #imageLiteral(resourceName: "sight 2.pdf"), #imageLiteral(resourceName: "sight 3.pdf")]
    

    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        if level.defaults.bool(forKey: "FisrtSight") == false {
            explainView.image = images[count]
            level.defaults.set(true, forKey: "FirstSight")
        }else {
            blackView.isHidden = true
        }

        let scene = FirstSight(size: view.bounds.size)
        scene.delegate = self as TransitionDelegate
        let skView = view as! SKView
        skView.preferredFramesPerSecond = 30
        skView.showsFPS = false
        skView.showsNodeCount = false
        skView.ignoresSiblingOrder = true
        skView.backgroundColor = .black
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
        
        
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

    @IBAction func next(_ sender: Any) {
        count += 1
        if count < 3 {
            explainView.image = images[count]
        }else if count == 3 {
            blackView.isHidden = true
        }
    }
    
    
}
