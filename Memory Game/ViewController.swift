//
//  ViewController.swift
//  Memory Game
//
//  Created by Nick Sagan on 15.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var flipsLabel: UILabel!
    @IBOutlet var cardsCollection: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    
    //var emoji = Emoji()
    private lazy var game = MemoryLogic(numberOfPairsOfCards: numberOfPairsOfCards)
    var numberOfPairsOfCards: Int {return (cardsCollection.count + 1) / 2}
    private(set) var flipCounter = 0 { didSet { flipsLabel.text = "Flips: \(flipCounter)" } }
    private(set) var scoreCounter = 0 { didSet { scoreLabel.text = "Score: \(scoreCounter)" } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flipCounter = 0
        scoreCounter = 0
        game = MemoryLogic(numberOfPairsOfCards: numberOfPairsOfCards)
        updateViewFromModel()
    }

    @IBAction func newGamePressed(_ sender: UIButton) {
 }
    
    @IBAction func cardButtonPressed(_ sender: UIButton) {
        //flipCounter += 1
        
        scoreCounter = game.getScore()
        flipCounter = game.getflipCounter()
        
        if let cardNumber = cardsCollection.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        
    }

    private func updateViewFromModel() {
        for index in 0..<cardsCollection.count {
            let button = cardsCollection[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(Emoji().getEmoji(forCard: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 0) : .systemOrange
            }
            
        }
    }
    
//    private func flipCard(withEmoji emoji: String, on button: UIButton){
//
//        if button.currentTitle == emoji {
//            button.setTitle("", for: UIControl.State.normal)
//            button.backgroundColor = .systemOrange
//        } else {
//            button.setTitle(emoji, for: UIControl.State.normal)
//            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        }
//
//    }
    
}
