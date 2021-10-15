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
    
    lazy var game = MemoryLogic(numberOfPairsOfCards: (cardsCollection.count + 1)/2)
    
    var flipCounter = 0 { didSet { scoreLabel.text = "Flips: \(flipCounter)" } }
    
    @IBAction func cardButtonPressed(_ sender: UIButton) {
        flipCounter += 1
        
        if let cardNumber = cardsCollection.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        
    }
    
    func updateViewFromModel() {
        for index in 0..<cardsCollection.count {
            let button = cardsCollection[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(forCard: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 0.1506722558) : #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            }
            
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
    
    var emojiArray = ["🐻", "🦊", "🐷", "🐶", "🐸", "🐥", "🐰", "🐭", "🦁"]
    var emoji = [Int:String]()
    
    func emoji(forCard card: Card) -> String {
        
        if emoji[card.identifier] == nil, emojiArray.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiArray.count)))
                emoji[card.identifier] = emojiArray.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}

