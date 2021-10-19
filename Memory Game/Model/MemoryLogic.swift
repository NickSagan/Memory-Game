//
//  MemoryLogic.swift
//  Memory Game
//
//  Created by Nick Sagan on 15.10.2021.
//

import AVFoundation
import Foundation

// main game logic
class MemoryLogic {
    
    // Instance of audioplayer
    var player: AVAudioPlayer!
    
    // This func will play a sound with given "name"
    func playSound(_ name: String) {
        let url = Bundle.main.url(forResource: "\(name)", withExtension: "wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player!.play()
    }
    
    private(set) var cards = [Card]()
    private var score = 0
    private var flipCounter = 0
    private(set) var matchCounter: Int
    private(set) var winGame = false {
        didSet {
            // Play WIN sound
            playSound("win")
            // Go through array of cards to face them all down
            for var card in cards {
                card.isFaceUp = false
                card.isMatched = true
                
            }
        }
    }
    
    // returning current score
    func getScore(timer: Int) -> Int {
        return score - timer
    }
    
    // returning current flips
    func getflipCounter() -> Int {
        return flipCounter
    }
    
    // this var is to save ID of the only one opened card on the playground
    private var onlyOneFaceUpCard: Int? {
        get {
            // filter вернет массив значений удовлетворяющих условиям closure
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            // If index of onlyOneFaceUpCard was setted from outside, then we go through the array of cards to face them all down, except this one index card
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    // this func works when user taps any card
    func chooseCard(at index: Int) {
        if winGame {
            return
        }
        // check if card's index is in array of cards of force crash
        assert(cards.indices.contains(index), "MemoryLogic.chooseCard() - index is not in the cards array")
        
        // if card is not opened
        if !cards[index].isMatched {
            
            // Updating counters
            flipCounter += 1
            score -= 1
            
            // Check if there is already opened card and if index of new card is equal to this opened card
            if let matchIndex = onlyOneFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex] == cards[index] {
                    
                    // Play match sound
                    playSound("match")
                    
                    // and if they match we set them both as .isMatched
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    
                    // Add some points to score
                    score += 20
                    // Decrease match counter by 1
                    matchCounter -= 1
                    
                    // Check a win statement: when all cards matched
                    if matchCounter == 0 {
                        winGame = true
                    }
                }
                // else we just mark it as opened
                cards[index].isFaceUp = true
            } else {
                // else if this is the firstly opened card we mark it as onlyOneFaceUp
                onlyOneFaceUpCard = index
            }
        }
    }
     
    init(numberOfPairsOfCards: Int) {
        
        // Setting match counter to number of pairs
        matchCounter = numberOfPairsOfCards
        
        //  Checking incoming "numberOfPairsOfCards" to be greater then 0. If it is not, then we crash app with following message
        assert(numberOfPairsOfCards > 0, "MemoryLogic.init - numberOfPairsOfCards must be greater then 0")
        
        // Clearing array of cards after possible previous games
        cards.removeAll()
        
        // Refreshing the array of cards with new ones
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            
        // IMPORTANT! We add two equal cards with the same ID in the array. So it will be possible to match them on the gamefield in future.
            cards += [card, card]
        }
        // Shuffle cards
        shuffleCards()
    }
    
    // Shuffle array of cards
    private func shuffleCards() {
        cards.shuffle()
        // play intro sound right before game begins
        playSound("match")
    }

}

// extension for collection Types, returns first (and the only one) element if there is only 1 element in this collection
extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
