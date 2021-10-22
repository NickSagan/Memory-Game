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
    
    // lazy var, so it can wait with Init until it will be called
    private lazy var game = MemoryLogic(numberOfPairsOfCards: numberOfPairsOfCards)
    var numberOfPairsOfCards: Int {return (cardsCollection.count + 1) / 2}
    
    // Counters and timer
    private(set) var flipCounter = 0 { didSet { flipsLabel.text = "Flips: \(flipCounter)" } }
    private(set) var scoreCounter = 0 { didSet { scoreLabel.text = "Score: \(scoreCounter)" } }
    private(set) var gameTimer = 0 { didSet { timerLabel.text = "Time: \(gameTimer)" } }
    
    // timerIsActive used to activate timer only once in a game
    var timerIsActive = false
    var myTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let username = NSUserName()
        print(username)
        
        // Set all counters to 0
        flipCounter = 0
        scoreCounter = 0
        gameTimer = 0
        // crete new game instance
        game = MemoryLogic(numberOfPairsOfCards: numberOfPairsOfCards)
        updateViewFromModel()
        
        // Hide WIN label
        winLabel.isEnabled = false
        winLabel.isHidden = true
        
        //  Autoresize New Game button so it will fit its width
        newGameButtonOutlet.titleLabel?.adjustsFontSizeToFitWidth = true
 
        // Set corner radius to all the cards
        for index in 0..<cardsCollection.count {
            cardsCollection[index].layer.cornerRadius = cardsCollection[index].intrinsicContentSize.height/5
        }
        
    }

    // This button returns to Root View
    @IBAction func newGamePressed(_ sender: UIButton) {
 }
    
    @IBAction func cardButtonPressed(_ sender: UIButton) {
        
        // Ignore this button's code if player already won
        if game.winGame {
            return
        }
        
        // Activate timer only at first card tap
        if !timerIsActive {
            myTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            timerIsActive = true
        }
        
        // update counters
        scoreCounter = game.getScore(timer: gameTimer)
        flipCounter = game.getflipCounter()
        
        // Check if cards is in cardsCollection and then choose it
        if let cardNumber = cardsCollection.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        
    }
    
    // Timer's func. Deactivates when player wins
    @objc func updateTimer(){
        gameTimer += 1
        if game.winGame {
            myTimer.invalidate()
            // Launc winGame func if player wins
            winGame()
        }
    }
    
    // Go through array of cards and update their view
    private func updateViewFromModel() {
        for index in 0..<cardsCollection.count {
            let button = cardsCollection[index]
            let card = game.cards[index]
            
            button.titleLabel?.numberOfLines = 1
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.titleLabel?.lineBreakMode = .byClipping
            
            if card.isFaceUp {
                button.setTitle(Theme().getEmoji(forCard: card), for: UIControl.State.normal)
                button.backgroundColor = Theme.cardFrontColor
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 0) : Theme.cardBackColor
            }
        }
    }
    
    // This func launches when player wins
    private func winGame() {
        
        // Go through array of cards to face them all down (to face down last two cards)
        for index in 0..<cardsCollection.count {
            cardsCollection[index].setTitle("", for: UIControl.State.normal)
            cardsCollection[index].backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 0)
        }
        
        // Show WIN label and autoresize it so it will fit any device
        winLabel.adjustsFontSizeToFitWidth = true
        winLabel.numberOfLines = 2
        winLabel.lineBreakMode = .byClipping
        winLabel.isHidden = false
        winLabel.isEnabled = true
        
        scoreCounter = game.finalScore
        winLabel.text = "You win!\nYour score: \(scoreCounter)"
        scoreCounter = game.finalScore
    }
}
