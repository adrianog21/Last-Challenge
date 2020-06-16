//
//  hapticViewController.swift
//  NewMaze
//
//  Created by Francesco Improta on 18/05/2020.
//  Copyright © 2020 Adriano Gatto. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit



class hapticViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var counter = 3
    
    
    @IBOutlet weak var lives: UILabel!
    
    @IBOutlet weak var blackView: UIView!
    
    @IBOutlet weak var explainView: UIImageView!
    
    var count = 0
    var images = [#imageLiteral(resourceName: "touch 1.pdf"), #imageLiteral(resourceName: "touch 2.pdf"), #imageLiteral(resourceName: "touch 3.pdf")]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count

    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIPickerView(frame: CGRect(x: 526, y: 20, width: 345, height: 78))
        let label = UILabel(frame: CGRect(x: 5, y: 0, width: view.frame.width, height: view.frame.height))
        label.text = pickerData[row]
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.medium)
        label.textColor = .white
        view.addSubview(label)
        
//        view.transform  = CGAffineTransform(rotationAngle: -90 * (.pi/180))
        return view
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = pickerData[row]
        let attributedString = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        return attributedString
    }
    
    var pickerData: [String] = [String]()
    
    var selectedValues: [Character] = ["A", "A", "A", "A"]
    
    
    
    
    
    @IBOutlet weak var picker: UIPickerView!
    
    @IBAction func control(_ sender: Any) {
        
        counter -= 1
        
        self.lives.text = String(counter);
        
        if selectedValues[0] == "H" && selectedValues[1] == "I" && selectedValues[2] == "F" && selectedValues[3] == "E" {
            
            level.getMinigame(game: "HapticGame")
            level.newScene(scene: "Win")
                   let storyboard = UIStoryboard(name: "Main", bundle: nil)
                       let vc = storyboard.instantiateViewController(withIdentifier: level.nextScene)
                   vc.view.frame = (self.view?.frame)!
                   vc.view.layoutIfNeeded()
                   UIView.transition(with: self.view!, duration: 0.3, options: .transitionFlipFromRight, animations:
                       {
                           self.view?.window?.rootViewController = vc
                   }, completion: { completed in
                   })
            
        }
        else {
            
//            let label = UILabel(frame: CGRect(x: 400, y: 200, width: 200, height: 200))
//            label.center = CGPoint(x: 0, y: 190)
//            label.textAlignment = .center
//            label.text = "Try Again"
//            label.textColor = .white
//            label.font = UIFont.boldSystemFont(ofSize: 36)
//            
//            UIView.animate(withDuration: 2, delay: 0, options: [.transitionCurlDown], animations: {
//                label.center.x += self.view.bounds.width
//                  self.view.layoutIfNeeded()
//            }, completion: nil)
//            self.view.addSubview(label)
            
            
            if counter == 0 {
                level.newScene(scene: "Lose")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: level.nextScene)
            vc.view.frame = (self.view?.frame)!
            vc.view.layoutIfNeeded()
            UIView.transition(with: self.view!, duration: 0.3, options: .transitionFlipFromRight, animations:
                {
                    self.view?.window?.rootViewController = vc
            }, completion: { completed in
            })
        }
        }
    }
    
    
    let emitterNode = SKEmitterNode(fileNamed: "Dust.sks")!
    
    private func addRain() {
        let skView = SKView(frame: view.frame)
        skView.backgroundColor = .clear
        let scene = SKScene(size: view.frame.size)
        scene.backgroundColor = .clear
        skView.presentScene(scene)
        skView.isUserInteractionEnabled = false
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        scene.addChild(emitterNode)
        emitterNode.position.y = scene.frame.maxY
        emitterNode.particlePositionRange.dx = scene.frame.width * 10
        view.addSubview(skView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if level.defaults.bool(forKey: "FirstHaptic") == false {
            explainView.image = images[count]
            level.defaults.set(true, forKey: "FirstHaptic")
        }else {
            blackView.isHidden = true
        }
        
        lives.textColor = .white
        lives.text = "\(counter)"
        
        addRain()
        
        if let view = self.view as! SKView? {
               // Load the SKScene from 'GameScene.sks'
        if let scene = SKScene(fileNamed: "firstHaptic") {
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
                       // Present the scene
            view.presentScene(scene)
        }
            
            pickerData = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P",
            "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
            
            
        
        self.picker.delegate = self
        self.picker.dataSource = self
            
            
//       picker.transform = CGAffineTransform(rotationAngle: 90 * (.pi/180))
        
    }
        
        

 

    
}
    

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        // selected value in Uipickerview in Swift
        
        func printValue1(){
            
        
            let selectedValue = pickerData[pickerView.selectedRow(inComponent: 0)]
            
            selectedValues.insert(contentsOf: selectedValue, at: 0)
            
            
//            selectedValues.append(contentsOf: selectedValue)
        
            print("valueData:----------\(selectedValue)");
        }
        
        
        func printValue2(){
            
        
            let selectedValue2 = pickerData[pickerView.selectedRow(inComponent: 1)]
            
            selectedValues.insert(contentsOf: selectedValue2, at: 1)
            
            
//            selectedValues.append(contentsOf: selectedValue2)
            
            print("valueData2:----------\(selectedValue2)");
        }
        
        func printValue3(){
            
        
         let selectedValue3 = pickerData[pickerView.selectedRow(inComponent: 2)]
            
            selectedValues.insert(contentsOf: selectedValue3, at: 2)
            
//            selectedValues.append(contentsOf: selectedValue3)
            
            print("valueData3:----------\(selectedValue3)");
        }
        
        func printValue4(){
            
        
         let selectedValue4 = pickerData[pickerView.selectedRow(inComponent: 3)]
            
            selectedValues.insert(contentsOf: selectedValue4, at: 3)
            
//            selectedValues.append(contentsOf: selectedValue4)
            
            
            print("valueData4:----------\(selectedValue4)");
        }
        
        
        
        func changeScene(){
            
            
            
            
            if pickerData[pickerView.selectedRow(inComponent: 0)] == "H" && pickerData[pickerView.selectedRow(inComponent: 1)] == "I" && pickerData[pickerView.selectedRow(inComponent: 2)] == "F" && pickerData[pickerView.selectedRow(inComponent: 3)] == "E"            {
                
                level.getMinigame(game: "HapticGame")
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
        }
        
        printValue1()
        printValue2()
        printValue3()
        printValue4()
        
        
        
        print(selectedValues)
        
        
//        changeScene()
        
//        selectedValues.removeAll()
        
    }
    
    @IBAction func next(_ sender: Any) {
        count += 1
        if count < 3 {
            explainView.image = images[count]
        } else if count == 3 {
            blackView.isHidden = true
        }
    }
    
}
