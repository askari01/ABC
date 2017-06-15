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
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var repeatBtn: UIButton!
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var ButtonA: UIButton!
    @IBOutlet weak var ButtonB: UIButton!
    @IBOutlet weak var ButtonC: UIButton!
    @IBOutlet weak var ButtonD: UIButton!
    
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
    var incorrect = 0
//    var button = []
    var buttonCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        skipBtn.layer.cornerRadius = 4
        repeatBtn.layer.cornerRadius = 4
        checkBtn.layer.cornerRadius = 4
        pic.layer.cornerRadius = 4
        pic.layer.borderWidth = 2
//        pic.layer.borderColor = #imageLiteral(resourceName: "black") as! CGColor
        ButtonA.layer.cornerRadius = 4
        ButtonB.layer.cornerRadius = 4
        ButtonC.layer.cornerRadius = 4
        ButtonD.layer.cornerRadius = 4
        
        score.text = "Score: \(String(describing: scored))"
        refresh()
    }
    
    @IBAction func next(_ sender: Any) {
        gameCheck()
        s = ""
        luckyWord = ""
        incorrect += 1
        refresh()
    }
    
    @IBAction func repeatAgain(_ sender: Any) {
        gameCheck()
        myUtterance = AVSpeechUtterance(string: luckyWord)
        myUtterance.rate = 0.07
        synth.speak(myUtterance)
    }
    
    @IBAction func check(_ sender: Any) {
        gameCheck()
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
            incorrect += 1
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
    
    func check(character: String) {
        gameCheck()
        print ("required ",luckyChar)
        print ("entered ",String(describing: character))
        print ("i AM ",String(describing:luckyChar!))
        let char = String(describing:luckyChar!)
        
        if char == character {
            luckyWord = ""
            s = ""
            guessedWord.text = ""
            myUtterance = AVSpeechUtterance(string: "")
            luckyChar = nil
            scored += 1
            refresh()
        } else {
            incorrect += 1
            var guessed = ""
            for index in s.characters.indices {
                if s[index] == "_" {
                    guessed += guessedWord.text!
                } else {
                    guessed += "\(luckyWord[index])"
                }
            }
            
            // If login fails
            self.pic.shake()
            
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
        gameCheck()
        let number = Int(arc4random_uniform(UInt32(words.count)))
        let buttonBumber = Int(arc4random_uniform(UInt32(4)))
        print ("Button Number: ", buttonBumber)
        
        luckyWord = words[number]
        word.text = luckyWord
        print ("lucky word:\(luckyWord): ", UIImage(named: luckyWord))
        self.pic.image = UIImage(named: luckyWord)
        
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
        
        for i in 1...4 {
//            print ("random Char\(i): ",randomString(length: 1, luckyChar: String(describing: luckyChar)))
            let abc = randomString(length: 1, luckyChar: String(describing: luckyChar))
            print (abc)
            if i == 1 {
                ButtonA.setTitle(abc, for: .normal)
            } else if i == 2 {
                ButtonB.setTitle(abc, for: .normal)
            } else if i == 3 {
                ButtonC.setTitle(abc, for: .normal)
            } else {
                ButtonD.setTitle(abc, for: .normal)
            }
        }
        
        if buttonBumber == 1 {
            ButtonA.setTitle(String(describing: luckyChar!), for: .normal)
        } else if buttonBumber == 2 {
            ButtonB.setTitle(String(describing: luckyChar!), for: .normal)
        } else if buttonBumber == 3 {
            ButtonC.setTitle(String(describing: luckyChar!), for: .normal)
        } else {
            ButtonD.setTitle(String(describing: luckyChar!), for: .normal)
        }
        
        print ("c: ",luckyChar)
        print ("n: ",luckyNumber)
        print ("s: ",s)
        word.text = s
        score.text = "Score: \(String(describing: scored))"
        
        myUtterance = AVSpeechUtterance(string: luckyWord)
        myUtterance.rate = 0.3
        synth.speak(myUtterance)
        
    }
    
    func gameCheck() {
        if incorrect == 3 {
            s = ""
            luckyWord = ""
            scored = 0
            incorrect = 0
            let alert = UIAlertController(title: "Game Over",
                                          message: "Try Again",
                                          preferredStyle: .alert)
            let defaultButton = UIAlertAction(title: "OK",
                                              style: .default) {(_) in
                                                // your defaultButton action goes here
                                                self.s = ""
                                                self.luckyWord = ""
                                                self.scored = 0
                                                self.incorrect = 0
                                                self.refresh()
            }
            alert.addAction(defaultButton)
            present(alert, animated: true) {
                // completion goes here
            }
        }
        if score.text == "80" {
            s = ""
            luckyWord = ""
            scored = 0
            incorrect = 0
            let alert = UIAlertController(title: "You Won !",
                                          message: "You have reach the end, game will now restart\nThanks for playing...",
                                          preferredStyle: .alert)
            let defaultButton = UIAlertAction(title: "OK",
                                              style: .default) {(_) in
                                                // your defaultButton action goes here
                                                self.s = ""
                                                self.luckyWord = ""
                                                self.scored = 0
                                                self.incorrect = 0
                                                self.refresh()
            }
            alert.addAction(defaultButton)
            present(alert, animated: true) {
                // completion goes here
                
            }
        }
    }
    
    func randomString(length: Int, luckyChar: String) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyz".replacingOccurrences(of: luckyChar, with: "") as NSString
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    @IBAction func checkA(_ sender: Any) {
        check(character: (ButtonA.titleLabel?.text!)!)
    }
    
    @IBAction func checkB(_ sender: Any) {
        check(character: (ButtonB.titleLabel?.text!)!)
    }
    
    @IBAction func checkC(_ sender: Any) {
        check(character: (ButtonC.titleLabel?.text!)!)
    }
    
    @IBAction func checkD(_ sender: Any) {
        check(character: (ButtonD.titleLabel?.text!)!)
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

