//
//  MemoryLogic.swift
//  Memory Game
//
//  Created by Nick Sagan on 15.10.2021.
//

import Foundation

class MemoryLogic {
    
    var cards = [Card]()
    
    var onlyOneFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        
        if !cards[index].isMatched {
            if let matchIndex = onlyOneFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                onlyOneFaceUpCard = nil
            } else {
                // either no cards or 2 cards face up
                for flipDownIndex in 1..<cards.count {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                onlyOneFaceUpCard = index
            }
        }
    }
     
    init(numberOfPairsOfCards: Int) {
        
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        shuffleCards()
    }
    
    func shuffleCards() {
        cards.shuffle()
    }
    
}
