//
//  Card.swift
//  Memory Game
//
//  Created by Nick Sagan on 15.10.2021.
//

import Foundation

// Hashable protocol used so we can hash our cards
struct Card: Hashable {

    // Hashing card by their ID
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    // By default any card is NOT matched and Faced down
    var isFaceUp = false
    var isMatched = false
    
    // Every new card will have it's own identifier
    private var identifier: Int
    
    // ID Fabcric. Creates unique identifier at the initialisation moment
    private static var idGenerator = 0
    private static func getUniqueID() -> Int {
        idGenerator += 1
        return idGenerator
    }
    init() {
        self.identifier = Card.getUniqueID()
    }
}
