//
//  MemoryLogic.swift
//  Memory Game
//
//  Created by Nick Sagan on 15.10.2021.
//

import Foundation

// main game logic - основная логика игры
class MemoryLogic {
    
    private(set) var cards = [Card]()
    private var score = 0
    private var flipCounter = 0
    private(set) var matchCounter: Int
    private(set) var winGame = false {
        didSet {
            for var card in cards {
                card.isFaceUp = false
                card.isMatched = true
                
            }
        }
    }
    
    // returning current score - Возвращаем очки
    func getScore(timer: Int) -> Int {
        return score - timer
    }
    
    // returning current flips - Возвращаем кол-во открытий карт
    func getflipCounter() -> Int {
        return flipCounter
    }
    
    // this var is to save ID of the only one opened card on the playground - эта переменная хранит айдишник единственной открытой карты на поле
    private var onlyOneFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            // go through the array of cards - пробегаем по массиву карт
            for index in cards.indices {
                // to find any already faced up card - чтобы найти уже открытую карту
                if cards[index].isFaceUp {
                    // if a faced up card found we will either return nil, if it is not the first one, or we will assign this card's index to foundIndex - если нашлась какая-то открытая карта, то мы либо вернем нил, если это не единственная карта на поле, либо присвоем индекс этой карты в переменную foundIndex
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            // returns nil or index of the only-one-open-faced-card on the field - возвращаем нил или индекс единственной открытой карты на поле
            return foundIndex
        }
        set {
            // If index of onlyOneFaceUpCard was setted from outside, then we go through the array of cards to face them all down, except this one index card - Если индекс единственной карты даётся извне, то пробегаем по массиву, кладём эту карту лицом вверх, а все остальные карты кладём лицом вниз.
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    // this func works when user taps any card - функция отрабатывает при нажатии на карту
    func chooseCard(at index: Int) {
        if winGame {
            return
        }
        // check if card's index is in array of cards of force crash - проверяем, что пришедший индекс находится в массиве всех карт, иначе крэшим со следующим сообщением
        assert(cards.indices.contains(index), "MemoryLogic.chooseCard() - index is not in the cards array")
        
        // if card is not opened - если карта не отрыта
        if !cards[index].isMatched {
            
            // Updating counters
            flipCounter += 1
            score -= 1
            
            // Check if there is already opened card and if index of new card is equal to this opened card - сверяем индекс новой карты с возможным индексом уже открытой карты
            if let matchIndex = onlyOneFaceUpCard, matchIndex != index {
                // check if cards match - проверяем на совпадение с уже открытой картой
                if cards[matchIndex].identifier == cards[index].identifier {
                    // and if they match we set them both as .isMatched - и если совпали, то помечаем обе карты, как открытые
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    
                    // Add some points to score - Добавляем очки
                    score += 20
                    // Decrease match counter by 1. Уменьшаем счетчик совпадений на 1
                    matchCounter -= 1
                    
                    // Check a win statement: when all cards matched - Проверяем на выигрыш, когда все пары карт совпали
                    if matchCounter == 0 {
                        winGame = true
                    }
                }
                // else we just mark it as opened - иначе помечаем эту карту, как открытую
                cards[index].isFaceUp = true
            } else {
                // else if this is the firstly opened card we mark it as onlyOneFaceUp - иначе, если это сейчас единственная открытая на поле карта, то помечаем её как единственную
                onlyOneFaceUpCard = index
            }
        }
    }
     
    init(numberOfPairsOfCards: Int) {
        
        // Setting match counter to number of pairs - заряжаем счетчик на кол-во пар карт
        matchCounter = numberOfPairsOfCards
        
        //  Checking incoming "numberOfPairsOfCards" to be greater then 0. If it is not, then we crash app with following message. Проверяем, что нам пришло большее чем ноль кол-во пар карт иначе крэшим с нижеследующим сообщением
        assert(numberOfPairsOfCards > 0, "MemoryLogic.init - numberOfPairsOfCards must be greater then 0")
        
        // Clearing array of cards after possible previous games. -  Чистим массив с картами от возможных предыдущих игр
        cards.removeAll()
        
        // Refreshing the array of cards with new ones. - Наполняем массив картами
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            
        // IMPORTANT! We add two equal cards with the same ID in the array. So it will be possible to match them on the gamefield in future.
        // ВАЖНО! Мы закидываем в массив две одинаковые копии карты, у которых будут одинаковые ID. Чтобы потом была возможность отслеживать их совпадение на поле.
            cards += [card, card]
        }
        // Shuffle cards. Перетасовываем.
        shuffleCards()
    }
    
    // Shuffle array of cards - Перетасовываем карты в массиве
    private func shuffleCards() {
        cards.shuffle()
    }
    
    
    func win() {
        
    }
    
}
