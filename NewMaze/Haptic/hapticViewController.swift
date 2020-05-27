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

var hapticController = hapticViewController()

class hapticViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
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
        label.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.medium)
        label.textColor = .white
        view.addSubview(label)
        
        view.transform  = CGAffineTransform(rotationAngle: -90 * (.pi/180))
        return view
    }
    func pickerView2(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData2.count

    }
    
    func pickerView2(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData2[row]
    }
    
    func pickerView3(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData3.count

    }
    
    func pickerView3(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData3[row]
    }
    
    func pickerView4(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData4.count

    }
    
    func pickerView4(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData4[row]
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = pickerData[row]
        let attributedString = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        return attributedString
    }
    
    func pickerView2(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = pickerData2[row]
        let attributedString = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        return attributedString
    }
    
    func pickerView3(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = pickerData3[row]
        let attributedString = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        return attributedString
    }
    
    func pickerView4(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = pickerData4[row]
        let attributedString = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        return attributedString
    }

    var pickerData: [String] = [String]()
    
    var pickerData2: [String] = [String]()
    
    var pickerData3: [String] = [String]()
    
    var pickerData4: [String] = [String]()
    
    @IBOutlet weak var picker: UIPickerView!
    
    @IBOutlet weak var picker1: UIPickerView!
    
    @IBOutlet weak var picker2: UIPickerView!
    
    
    @IBOutlet weak var picker3: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let view = self.view as! SKView? {
//               // Load the SKScene from 'GameScene.sks'
//            if let scene = SKScene(fileNamed: "FirstHaptic"){
//            // Set the scale mode to scale to fit the window
//            scene.scaleMode = .aspectFill
//                       // Present the scene
//            view.presentScene(scene)
//            }
        
        let scene = SKScene(fileNamed: "firstHaptic")
        let skView = view as! SKView
        scene?.scaleMode = .aspectFill
        skView.presentScene(scene)
            
            pickerData = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p",
            "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
             
            pickerData2 = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p",
            "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
            
            pickerData3 = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p",
            "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
            
            pickerData4 = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p",
            "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
            
            
             self.picker.delegate = self
             self.picker.dataSource = self
            
             self.picker1.delegate = self
             self.picker1.dataSource = self
             
             self.picker2.delegate = self
             self.picker2.dataSource = self
             
             self.picker3.delegate = self
             self.picker3.dataSource = self
            
            
            picker.transform = CGAffineTransform(rotationAngle: 90 * (.pi/180))
            picker1.transform = CGAffineTransform(rotationAngle: 90 * (.pi/180))
            picker2.transform = CGAffineTransform(rotationAngle: 90 * (.pi/180))
            picker3.transform = CGAffineTransform(rotationAngle: 90 * (.pi/180))
            
        
        
//            }
        
    
        
        
       
        
        
        
}
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        // selected value in Uipickerview in Swift
        let value = pickerData[row]
        
        
        
        print("valuesData:----------\(value)");
        
//        if value == "h"{
//            if let view = self.view as! SKView? {
//                   // Load the SKScene from 'GameScene.sks'
//            if let scene = SKScene(fileNamed: "GameScene") {
//                // Set the scale mode to scale to fit the window
//                scene.scaleMode = .aspectFill
//                           // Present the scene
//                view.presentScene(scene)
//            }
//        }
//
//           }
    }
    
    func pickerView2(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        // selected value in Uipickerview in Swift
        let value2 = pickerData2[row]
        print("valuesData:----------\(value2)");
        
           }
    
    func pickerView3(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        // selected value in Uipickerview in Swift
        let value3 = pickerData3[row]
        print("valuesData:----------\(value3)");
        
           }
    
    func pickerView4(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        // selected value in Uipickerview in Swift
        let value4 = pickerData4[row]
        print("valuesData:----------\(value4)");
        
        
           }
    
    
    
}
