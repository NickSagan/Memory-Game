//
//  ViewController.swift
//  Memory Game
//
//  Created by Nick Sagan on 15.10.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardsCollection: [UIButton]!
    
    var flipCounter = 0 {
        didSet {
            scoreLabel.text = "Flips: \(flipCounter)"
        }
    }
    
    var emojiArray = ["🐻", "🦊", "🐷", "🐻", "🦊", "🐷"]
    
    @IBAction func cardButtonPressed(_ sender: UIButton) {
        flipCounter += 1
        
        if let cardNumber = cardsCollection.firstIndex(of: sender) {
            flipCard(withEmoji: emojiArray[cardNumber], on: sender)
        }
        
    }
    
    func flipCard(withEmoji emoji: String, on button: UIButton){
        
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        } else {
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
    }
    

}

