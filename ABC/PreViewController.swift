//
//  PreViewController.swift
//  ABC
//
//  Created by Syed Askari on 15/06/2017.
//  Copyright © 2017 Askari. All rights reserved.
//

import UIKit

class PreViewController: UIViewController {
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var highScoreButton: UIButton!
    
    // create defaults
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        startButton.layer.cornerRadius = 4
        highScoreButton.layer.cornerRadius = 4
        
        if defaults.string(forKey: "highestScore") != nil {
            highScoreButton.isHidden = false
            highScoreButton.setTitle("High Score\n\(String(describing: defaults.string(forKey: "highestScore")!))", for: .normal)
            highScoreButton.titleLabel?.numberOfLines = 2
            highScoreButton.titleLabel?.textAlignment = NSTextAlignment.center
        }
    }

    @IBAction func startGameAction(_ sender: Any) {
        defaults.set("0", forKey: "highestScore")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "VC") as! ViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func highScoreAction(_ sender: Any) {
        let alert = UIAlertController(title: "High Score",
                                      message: "32",
                                      preferredStyle: .alert)
        let defaultButton = UIAlertAction(title: "OK",
                                          style: .default) {(_) in
                                            // your defaultButton action goes here
        }
        alert.addAction(defaultButton)
        present(alert, animated: true) {
            // completion goes here
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
