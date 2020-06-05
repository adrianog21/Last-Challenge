//
//  Story.swift
//  NewMaze
//
//  Created by Adriano Gatto on 01/06/2020.
//  Copyright © 2020 Adriano Gatto. All rights reserved.
//
import GameKit
import UIKit
import SpriteKit

weak var story = Story()

class Story : UIViewController{
    
    var audioPlayer: AVAudioPlayer?
    
    var start1 = "Welcome. \n Your body is lost somewhere along with your senses. \n You were not supposed to be conscious and hear me."
    var start2 = "Don’t despair, \n this is your chance to acquire your human vitality back \n before irreversibly sinking into the darkness."
    var start3 = "I am going to light up the way, \n following your every direction. \n This is going to feel like a maze..."
    var start4 = "It is."
    var start5 = "I wonder… \n Slits of light may still be open. \n find them and try to force your senses back"
    
    var firstGameDone1 = "You are starting to feel your senses again… \n It may feel frightening at first."
    var firstGameDone2 = "However you still need more to be free to live again. \n Continue your journey."
    var allGamesDone1 = "You have never felt this human in a long time. \n And I am starting to fade back into your consciousness…"
    var allGamesDone2 = "Time is killer now. \n Here’s my last advice…"
    var allGamesDone3 = "Now you are able to feel the presence of three pulses. \n Before they were unreachable for your senseless essence."
    var allGamesDone = "Find them and find your way out \n Hurry with the last help I can offer!"
    
    var firstFail1 = "Seems like you were not stable enough to withstand the impact of acquiring this sense back yet."
    var firstFail2 = "The attempt left you a bit disoriented… \n But don’t give up, find the right path again."
    
    var words = [String]()
    
    var num = 0
    
    @IBOutlet weak var textSong: UILabel!
    @IBOutlet weak var loveText: UILabel!
    @IBOutlet weak var fadeView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
//        scene = HB(size: view.bounds.size)
//        let skView = view as! SKView
//        skView.preferredFramesPerSecond = 30
////        skView.showsFPS = false
////        skView.showsNodeCount = false
////        skView.ignoresSiblingOrder = true
//        skView.backgroundColor = .black
//        scene.scaleMode = .resizeFill
//        skView.presentScene(scene)
        
//        words.append(third)
//        words.append(fourth)
//        words.append(first)
//        words.append(second)
//        words.append(fifth)
//        words.append(sixth)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(start))
        self.view.addGestureRecognizer(gesture)
        loveText.alpha = 0
        
        UIView.animate(withDuration: 10, animations: {
            self.fadeView.alpha = 0
        })
    }
    
    @objc func start(){
        num += 1
        if num - 1 < words.count {
            
        textSong.text = ""
        for i in words[num - 1] {
            AudioServicesPlaySystemSound(1105)
            textSong.text! += "\(i)"
            RunLoop.current.run(until: Date()+0.1)
        }
        
        }else {
            UIView.animate(withDuration: 1, animations: {
                self.loveText.alpha = 1
            })
        }
    }
    
}