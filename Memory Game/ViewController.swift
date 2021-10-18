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
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var newGameButtonOutlet: UIButton!
    
    private lazy var game = MemoryLogic(numberOfPairsOfCards: numberOfPairsOfCards)
    var numberOfPairsOfCards: Int {return (cardsCollection.count + 1) / 2}
    private(set) var flipCounter = 0 { didSet { flipsLabel.text = "Ходы: \(flipCounter)" } }
    private(set) var scoreCounter = 0 { didSet { scoreLabel.text = "Очки: \(scoreCounter)" } }
    private(set) var gameTimer = 0 { didSet { timerLabel.text = "Время: \(gameTimer)" } }
    
    var timerIsActive = false
    var myTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flipCounter = 0
        scoreCounter = 0
        gameTimer = 0
        game = MemoryLogic(numberOfPairsOfCards: numberOfPairsOfCards)
        updateViewFromModel()
        winLabel.isEnabled = false
        winLabel.isHidden = true
        view.backgroundColor = Theme.backgroundColor
        flipsLabel.textColor = Theme.cardBackColor
        scoreLabel.textColor = Theme.cardBackColor
        timerLabel.textColor = Theme.cardBackColor
        newGameButtonOutlet.setTitleColor(Theme.cardBackColor, for: UIControl.State.normal)
    }

    // returns to Root View - Возврат на стартовую страницу
    @IBAction func newGamePressed(_ sender: UIButton) {
 }
    
    @IBAction func cardButtonPressed(_ sender: UIButton) {
        
        if game.winGame {
            return
        }
        
        if !timerIsActive {
            myTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            timerIsActive = true
        }
        
        scoreCounter = game.getScore(timer: gameTimer)
        flipCounter = game.getflipCounter()
        
        if let cardNumber = cardsCollection.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        
    }
    
    @objc func updateTimer(){
        gameTimer += 1
        if game.winGame {
            myTimer.invalidate()
            winGame()
        }
    }

    private func updateViewFromModel() {
        for index in 0..<cardsCollection.count {
            let button = cardsCollection[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(Theme().getEmoji(forCard: card), for: UIControl.State.normal)
                button.backgroundColor = Theme.cardFrontColor
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 0) : Theme.cardBackColor
            }
        }
    }
    
    private func winGame() {
        for index in 0..<cardsCollection.count {
            cardsCollection[index].setTitle("", for: UIControl.State.normal)
            cardsCollection[index].backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 0)
        }
        
        winLabel.isHidden = false
        winLabel.isEnabled = true
        
    }
}
