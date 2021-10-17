//
//  MemoryLogic.swift
//  Memory Game
//
//  Created by Nick Sagan on 15.10.2021.
//

import Foundation

class MemoryLogic {
    
    private(set) var cards = [Card]()
    
    private var onlyOneFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "MemoryLogic.chooseCard() - index is not in the cards array")
        if !cards[index].isMatched {
            if let matchIndex = onlyOneFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                // either no cards or 2 cards face up
                onlyOneFaceUpCard = index
            }
        }
    }
     
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "MemoryLogic.init - numberOfPairsOfCards must be greater then 0")
        cards.removeAll()
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        shuffleCards()
    }
    
    private func shuffleCards() {
        cards.shuffle()
    }
    
}
