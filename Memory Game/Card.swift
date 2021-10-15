//
//  Card.swift
//  Memory Game
//
//  Created by Nick Sagan on 15.10.2021.
//

import Foundation

struct Card {
    
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var idGenerator = 0
    
    static func getUniqueID() -> Int {
        idGenerator += 1
        return idGenerator
    }
    
    init() {
        self.identifier = Card.getUniqueID()
    }
}
