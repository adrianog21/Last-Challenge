//
//  SoundViewController.swift
//  NewMaze
//
//  Created by Martina Dinardo on 05/06/2020.
//  Copyright © 2020 Adriano Gatto. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class SoundViewController: UIViewController, TransitionDelegate {
        
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var explaiView: UIImageView!
    var count = 0
    
    let images = [#imageLiteral(resourceName: "sound 1.pdf"), #imageLiteral(resourceName: "sound 2.pdf"), #imageLiteral(resourceName: "sound 3.pdf")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        if level.defaults.bool(forKey: "FirstSound") == false {
            explaiView.image = images[count]
            level.defaults.set(true, forKey: "FirstSound")
        }else {
            blackView.isHidden = true
        }
        
       if let view = self.view as! SKView? {
                   // Load the SKScene from 'GameScene.sks'
                   if let scene = SKScene(fileNamed: "SoundScene") {
                       
                       // Set the scale mode to scale to fit the window
                       scene.scaleMode = .aspectFill

                       // Present the scene
                       view.presentScene(scene)
                    
                    scene.delegate = self as TransitionDelegate

                   }
    }
    
    
     var shouldAutorotate: Bool {
        return false
    }

     var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
        }
        
         var prefersStatusBarHidden: Bool {
            return true
        }
    }
    
    @IBAction func nextView(_ sender: Any) {
        count += 1
        if count < 3 {
            explaiView.image = images[count]
        }else if count == 3 {
            blackView.isHidden = true
        }
    }
    
    func returnToMainMenu(){
         let appDelegate = UIApplication.shared.delegate as! AppDelegate
//         guard  let storyboard = appDelegate.window?.rootViewController?.storyboard else { return }
//         if let vc = storyboard.instantiateInitialViewController() {
//             print("go to main menu")
//             self.present(vc, animated: false, completion: nil)
//         }
        
        let VC = self.storyboard!.instantiateViewController(withIdentifier: level.nextScene) as! UINavigationController
        self.navigationController?.present(VC, animated: false, completion: nil)
     }
}
