//
//  ViewController.swift
//  CatchTheGeraltGame
//
//  Created by Atakan on 18.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    //Views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var geralt1: UIImageView!
    @IBOutlet weak var geralt2: UIImageView!
    @IBOutlet weak var geralt3: UIImageView!
    @IBOutlet weak var geralt4: UIImageView!
    @IBOutlet weak var geralt5: UIImageView!
    @IBOutlet weak var geralt6: UIImageView!
    @IBOutlet weak var geralt7: UIImageView!
    @IBOutlet weak var geralt8: UIImageView!
    @IBOutlet weak var geralt9: UIImageView!
    
    //Variables
    var timer = Timer()
    var hideTimer = Timer()
    var counter = 0
    var score = 0
    var highScore = 0
    var geraltArray = [UIImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        geralt1.isUserInteractionEnabled = true
        geralt2.isUserInteractionEnabled = true
        geralt3.isUserInteractionEnabled = true
        geralt4.isUserInteractionEnabled = true
        geralt5.isUserInteractionEnabled = true
        geralt6.isUserInteractionEnabled = true
        geralt7.isUserInteractionEnabled = true
        geralt8.isUserInteractionEnabled = true
        geralt9.isUserInteractionEnabled = true
        
        let gestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        geralt1.addGestureRecognizer(gestureRecognizer1)
        geralt2.addGestureRecognizer(gestureRecognizer2)
        geralt3.addGestureRecognizer(gestureRecognizer3)
        geralt4.addGestureRecognizer(gestureRecognizer4)
        geralt5.addGestureRecognizer(gestureRecognizer5)
        geralt6.addGestureRecognizer(gestureRecognizer6)
        geralt7.addGestureRecognizer(gestureRecognizer7)
        geralt8.addGestureRecognizer(gestureRecognizer8)
        geralt9.addGestureRecognizer(gestureRecognizer9)
        
        geraltArray = [geralt1,geralt2,geralt3,geralt4,geralt5,geralt6,geralt7,geralt8,geralt9]
        
        //high score check
        scoreLabel.text = "Score : \(score)"
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highScore")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "High Score : \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "High Score : \(highScore)"
        }
        
        //timers
        counter = 10
        timeLabel.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideGeralt), userInfo: nil, repeats: true)
        
        hideGeralt()
    }
    
    @objc func hideGeralt(){
        for geralt in geraltArray {
            geralt.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(geraltArray.count - 1)))
        geraltArray[random].isHidden = false
    }
    
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score : \(score)"
    }
    
    
    @objc func countDown(){
        timeLabel.text = "Time : \(counter)"
        counter -= 1
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            timeLabel.text = "Time's Over"
            
            for geralt in geraltArray {
                geralt.isHidden = true
            }
            
            if score > highScore {
                highScore = score
                highScoreLabel.text = "High Score : \(highScore)"
                UserDefaults.standard.set(highScore, forKey: "highScore")
            }
            
            showAlert(titleInput: "Time's Over", messageInput: "Do you want to play again")
        }
        
    }
    
    @objc func showAlert(titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default ){(UIAlertAction) in
            self.gameReplay()
        }
        
        alert.addAction(okButton)
        alert.addAction(replayButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func gameReplay(){
        self.score = 0
        self.scoreLabel.text = "Score : \(self.score)"
        self.counter = 10
        self.timeLabel.text = String(self.counter)
        
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
        self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideGeralt), userInfo: nil, repeats: true)
    }
    
}
