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
    
    var first = "Juliet, when we made love you used to cry"
    var second = "You said 'I love you like the stars above, I'll love you 'til I die'"
    var third = "Juliet, the dice was loaded from the start"
    var fourth = "And I bet, and you exploded into my heart"
    var fifth = "I can't do everything but I'd do anything for you"
    var sixth = "I can't do anything except be in love with you..."
    
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
        
        words.append(third)
        words.append(fourth)
        words.append(first)
        words.append(second)
        words.append(fifth)
        words.append(sixth)
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
