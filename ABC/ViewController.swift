//
//  ViewController.swift
//  ABC
//
//  Created by Syed Askari on 07/06/2017.
//  Copyright © 2017 Askari. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var word: UILabel!
    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var guessedWord: UITextField!
    
    var words = [
    "acorn",
    "apple",
    "backpack",
    "ball",
    "barn",
    "basket",
    "basketball",
    "bear",
    "bed",
    "bee",
    "black",
    "blue",
    "boat",
    "book",
    "brown",
    "bus",
    "cake",
    "california",
    "camera",
    "candy",
    "car",
    "cat",
    "chair",
    "cloud",
    "cow",
    "dog",
    "doll",
    "donkey",
    "duck",
    "elephant",
    "extinguisher",
    "fire",
    "firefighter",
    "fish",
    "four",
    "fox",
    "giraffe",
    "globe",
    "goat",
    "green",
    "hat",
    "horse",
    "hose",
    "house",
    "hydrant",
    "ladder",
    "leaf",
    "leaves",
    "markers",
    "monkey",
    "moose",
    "one",
    "orange",
    "orchard",
    "oregon",
    "panda",
    "people",
    "pie",
    "pig",
    "pink",
    "plane",
    "pumpkin",
    "purple",
    "rain",
    "rake",
    "red",
    "road",
    "rollercoaster",
    "room",
    "ruler",
    "saw",
    "scarecrow",
    "school",
    "seed",
    "shell",
    "snow",
    "soccerball",
    "stars",
    "sun",
    "taxi",
    "teacher",
    "three",
    "train",
    "tree",
    "truck",
    "two",
    "white",
    "yellow"
    ]
    
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")
    var luckyWord = ""
    var luckyChar: Character!
    var s: String = ""
    var scored = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        guessedWord.delegate = self
        score.text = String(describing: scored)
        refresh()
    }
    
    @IBAction func next(_ sender: Any) {
        refresh()
    }
    
    @IBAction func repeatAgain(_ sender: Any) {
        myUtterance = AVSpeechUtterance(string: luckyWord)
        myUtterance.rate = 0.07
        synth.speak(myUtterance)
    }
    
    @IBAction func check(_ sender: Any) {
        print (luckyChar)
        print (guessedWord.text!)
        print (String(describing:luckyChar))
        let char = String(describing:luckyChar!)
        if char == guessedWord.text! {
            luckyWord = ""
            s = ""
            guessedWord.text = ""
            myUtterance = AVSpeechUtterance(string: "")
            luckyChar = nil
            scored += 1
            refresh()
        } else {
            var guessed = ""
            for index in s.characters.indices {
                if s[index] == "_" {
                    guessed += guessedWord.text!
                } else {
                    guessed += "\(luckyWord[index])"
                }
            }
            
            // If login fails
            self.guessedWord.shake()
            
            print (guessed)
            myUtterance = AVSpeechUtterance(string: guessed)
            myUtterance.rate = 0.1
            synth.speak(myUtterance)
            guessedWord.text = ""
            
            myUtterance = AVSpeechUtterance(string: luckyWord)
            myUtterance.rate = 0.1
            synth.speak(myUtterance)
        }
    }
    
    func refresh() {
        let number = Int(arc4random_uniform(UInt32(words.count)))
        luckyWord = words[number]
        word.text = luckyWord
        pic.image = UIImage(named: luckyWord)
        
        let luckyNumber = Int(arc4random_uniform(UInt32(luckyWord.count-1)))
        
        let characterIndex2 =  luckyWord.characters.index(luckyWord.characters.startIndex,offsetBy: luckyNumber)
        luckyChar = luckyWord.characters[characterIndex2]
        
        for index in luckyWord.characters.indices {
            if luckyChar == luckyWord[index] {
                s += "_"
            } else {
                s += "\(luckyWord[index])"
                print(luckyWord[index])
            }
        }
        print ("c: ",luckyChar)
        print ("n: ",luckyNumber)
        print ("s: ",s)
        word.text = s
        score.text = String(describing:scored)
        
        myUtterance = AVSpeechUtterance(string: luckyWord)
        myUtterance.rate = 0.3
        synth.speak(myUtterance)
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension UIView {
    
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
    
}

