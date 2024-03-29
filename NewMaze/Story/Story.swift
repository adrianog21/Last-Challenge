//
//  Story.swift
//  NewMaze
//
//  Created by Adriano Gatto on 01/06/2020.
//  Copyright © 2020 Adriano Gatto. All rights reserved.
//
//
import GameKit
import UIKit
import SpriteKit

weak var story = Story()

class Story : UIViewController{
    
    @IBOutlet weak var nextButton: UIButton!
    var audioPlayer: AVAudioPlayer?
    
    var start1 = "Welcome. \nYour body is lost somewhere along with your senses. \nYou were not supposed to be conscious and hear me."
    var start2 = "Don’t despair, \nthis is your chance to acquire your human vitality back \nbefore irreversibly sinking into the darkness."
    var start3 = "I am going to light up the way, \nfollowing your every direction. \nThis is going to feel like a maze..."
    var start4 = "It is."
    var start5 = "I wonder… \nSlits of light may still be open. \nFind them and try to force your senses back"
    
    var firstGameDone1 = "You are starting to feel your senses again… \nIt may feel frightening at first."
    var firstGameDone2 = "However you still need more to be free to live again. \nContinue your journey."
    
    var allGamesDone1 = "You have never felt this human in a long time. \nAnd I am starting to fade back into your consciousness…"
    var allGamesDone2 = "Time is killer now. \nHere’s my last advice…"
    var allGamesDone3 = "Now you are able to feel the presence of three pulses. \nBefore, they were unreachable for your senseless essence."
    var allGamesDone4 = "Find them and find your way out \nHurry with the last help I can offer!"
    
    var firstFail1 = "Seems like you were not stable enough to withstand the impact of acquiring this sense back yet."
    var firstFail2 = "The attempt left you a bit disoriented… \nBut don’t give up, find the right path again."
    
    var ending1 = "The time has come for you to win your last challenge."
     var ending2 = "My light will enlight your way towards the end of your mind, if it starts to fade you are on the wrong path. \nFind the exit and...live."
    
    var gameOver1 = "Mourning and giref weight on your beloved ones"
    var gameOver2 = "May fading out with your soul be peaceful."
    
    var words = [[String]]()
    var words0 = [String]()
    var words1 = [String]()
    var words2 = [String]()
    var words3 = [String]()
    var words4 = [String]()
    var words5 = [String]()
    
    var frase = [String]()
    
    var num = 0
    var wordNum = 0
    
    @IBOutlet weak var textStory: UILabel!
    //    @IBOutlet weak var loveText: UILabel!
    @IBOutlet weak var fadeView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        words0.append(start1)
        words0.append(start2)
        words0.append(start3)
        words0.append(start4)
        words0.append(start5)
        
        words1.append(firstGameDone1)
        words1.append(firstGameDone2)
        
        words2.append(firstFail1)
        words2.append(firstFail2)
        
        words3.append(allGamesDone1)
        words3.append(allGamesDone2)
        words3.append(allGamesDone3)
        words3.append(allGamesDone4)
        
        words4.append(ending1)
        words4.append(ending2)
        
        words5.append(gameOver1)
        words5.append(gameOver2)
        
        words.append(words0)
        words.append(words1)
        words.append(words2)
        words.append(words3)
        words.append(words4)
        words.append(words5)
        
        frase = words[level.defaults.integer(forKey: "story")]
        
        UIView.animate(withDuration: 5, animations: {
            self.fadeView.alpha = 0
        })
    }
    
        func start(){
        num += 1
            if num - 1 < frase.count {
            
        textStory.text = ""
        for i in frase[num - 1] {
            wordNum += 1
            AudioServicesPlaySystemSound(1105)
            textStory.text! += "\(i)"
            RunLoop.current.run(until: Date()+0.07)
            if wordNum == frase[num - 1].count{
                nextButton.isHidden = false
                wordNum = 0
            }
        }
        
            }else {
                if level.defaults.integer(forKey: "story") == 5 {
                    level.resetData()
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "Start")
                    vc.view.frame = (self.view?.frame)!
                    vc.view.layoutIfNeeded()
                    UIView.transition(with: self.view!, duration: 0.3, options: .transitionFlipFromRight, animations:
                        {
                            self.view?.window?.rootViewController = vc
                    }, completion: { completed in
                    })
                }else {
                    
                    //         UIView.animate(withDuration: 1, animations: {
                    //                let VC = self.storyboard!.instantiateViewController(withIdentifier: "MazeGame") as! UINavigationController
                    //                self.navigationController?.present(VC, animated: false, completion: nil)
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "MazeGame")
                    vc.view.frame = (self.view?.frame)!
                    vc.view.layoutIfNeeded()
                    UIView.transition(with: self.view!, duration: 0.3, options: .transitionFlipFromRight, animations:
                        {
                            self.view?.window?.rootViewController = vc
                    }, completion: { completed in
                    })
                    
                }
       //     })
        }
    }
    
    @IBAction func NextWord(_ sender: Any) {
        nextButton.isHidden = true

        start()
    }
    
    
}
