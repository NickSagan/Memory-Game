//
//  Card.swift
//  Memory Game
//
//  Created by Nick Sagan on 15.10.2021.
//

import Foundation

struct Card {
    
    // By default any card is NOT matched and Face down - По умолчанию карты генерятся, как несовпавшие и лицом вниз
    var isFaceUp = false
    var isMatched = false
    
    // Every new card will have it's own ID - каждая сгенерированная карта получает свой ID
    var identifier: Int
    
    // ID Fabcric. Creates new ID at the initialisation moment. Генератор ID. Генерит уникальные айдишники при инициализации карты.
    private static var idGenerator = 0
    private static func getUniqueID() -> Int {
        idGenerator += 1
        return idGenerator
    }
    init() {
        self.identifier = Card.getUniqueID()
    }
}
