//
//  GameViewController.swift
//  NewMaze
//
//  Created by Adriano Gatto on 14/05/2020.
//  Copyright © 2020 Adriano Gatto. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

weak var gamecontroller = GameViewController()

class GameViewController: UIViewController {
    
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var duePunti: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    
    @IBOutlet weak var keysView: UIView!
    
    
    var OurTimer = Timer()
    var seconds = Int()
    var minutes = Int()
    
    func startTimer() {
        if level.defaults.bool(forKey: "timer") == true{
            minutesLabel.isHidden = false
            duePunti.isHidden = false
            secondsLabel.isHidden = false
            OurTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Action) , userInfo: nil, repeats: true)
        }else{return}
        
        
    }
    
    @objc func Action() {
        seconds -= 1
        level.defaults.set(seconds, forKey: "seconds")
        level.defaults.set(minutes, forKey: "minutes")
        if seconds == -1 {
         minutes -= 1
            seconds = 59
        }
        secondsLabel.text = String(seconds)
        minutesLabel.text = String(minutes)
    }
    
    
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var blackView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gamecontroller = self
        
            minutes = level.defaults.integer(forKey: "minutes")
            seconds = level.defaults.integer(forKey: "seconds")
        
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                
                // Copy gameplay related content over to the scene
//                sceneNode.entities = scene.entities
//                sceneNode.graphs = scene.graphs
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.preferredFramesPerSecond = 30
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
//                    view.showsNodeCount = true
                    
                    view.showsPhysics = false
                    
                    UIView.animate(withDuration: 3, animations: {self.blackView.alpha = 0})
                    minutesLabel.isHidden = true
                    duePunti.isHidden = true
                    secondsLabel.isHidden = true
                    startTimer()
                }
            }
        }
    }

        func newScene(scene : String) {
            print(scene)

            if scene == "MazeGame"{
                let VC = self.storyboard!.instantiateViewController(withIdentifier: level.nextScene) as! UINavigationController
                self.navigationController?.present(VC, animated: false, completion: nil)
            }else{
//            let VC = UIStoryboard(name: "Main", bundle:  Bundle.main).instantiateViewController(withIdentifier: scene) as? UINavigationController
//            print(VC as Any)
            let VC = self.storyboard!.instantiateViewController(withIdentifier: scene) as! UINavigationController
            self.navigationController?.present(VC, animated: false, completion: nil)
//                self.navigationController.pre
        }
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
