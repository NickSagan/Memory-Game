//
//  Emoji.swift
//  Memory Game
//
//  Created by Nick Sagan on 17.10.2021.
//

import Foundation

class Emoji {
    
    var theme = ["Animal", "Fruit", "Food", "Transport", "Plant", "Sport"]
    var selectedTheme = "Animal"
    
    func setTheme(set theme: String){
        selectedTheme = theme
    }
    
    var emojiAnimal = ["🐻", "🦊", "🐷", "🐶", "🐸", "🐥", "🐰", "🐭", "🦁", "🐼", "🦋", "🐮"]
    var emojiFruit = ["🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🍒", "🫐", "🥝", "🍍"]
    var emojiFood = ["🧀", "🍳", "🥞", "🌭", "🍔", "🍟", "🍕", "🥪", "🍗", "🥗", "🌮", "🍝"]
    var emojiTransport = ["🚗", "🚕", "🚑", "🚒", "🚎", "✈️", "🚁", "🚂", "🏍", "⛵️", "🚢", "🚛"]
    var emojiPlant = ["🌵", "🎄", "🌳", "🌴", "☘️", "🪴", "🍁", "🍄", "🌹", "🌻", "🌸", "🌼"]
    var emojiSport = ["⚽️", "🏀", "🏓", "🤿", "🏹", "🛼", "⛸", "🚴‍♂️", "🏆", "🥇", "🏂", "🛹"]
    
    private static var emoji = [Int:String]()
    static var emojiArray = [String]()
    
    func getEmoji(forCard card: Card) -> String {
        if Emoji.emoji[card.identifier] == nil, Emoji.emojiArray.count > 0 {
            Emoji.emoji[card.identifier] = Emoji.emojiArray.remove(at: Emoji.emojiArray.count.arc4random)
        }
        return Emoji.emoji[card.identifier] ?? "?"
    }
    
    func refreshEmojiArray() {
        switch selectedTheme {
        case "Animal": Emoji.emojiArray = emojiAnimal
        case "Fruit": Emoji.emojiArray = emojiFruit
        case "Food": Emoji.emojiArray = emojiFood
        case "Transport": Emoji.emojiArray = emojiTransport
        case "Plant": Emoji.emojiArray = emojiPlant
        case "Sport": Emoji.emojiArray = emojiSport
        default: Emoji.emojiArray = emojiAnimal
        }
    }
}

//MARK: - Int extension for random generation

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
