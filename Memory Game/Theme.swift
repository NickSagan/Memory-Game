//
//  Theme.swift
//  Memory Game
//
//  Created by Nick Sagan on 17.10.2021.
//

import UIKit

class Theme {
    
    var theme = ["Animal", "Fruit", "Food", "Transport", "Plant", "Sport"]
    private var selectedTheme = "Animal"
    static var bgcolor: UIColor = .systemBlue
    
    func setTheme(set theme: String){
        selectedTheme = theme
        refreshEmojiArray()
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
        if Theme.emoji[card.identifier] == nil, Theme.emojiArray.count > 0 {
            Theme.emoji[card.identifier] = Theme.emojiArray.remove(at: Theme.emojiArray.count.arc4random)
        }
        return Theme.emoji[card.identifier] ?? "?"
    }
    
    func refreshEmojiArray() {
        switch selectedTheme {
        case "Animal": Theme.emojiArray = emojiAnimal
            Theme.bgcolor = .systemOrange
        case "Fruit": Theme.emojiArray = emojiFruit
            Theme.bgcolor = .systemRed
        case "Food": Theme.emojiArray = emojiFood
            Theme.bgcolor = .systemYellow
        case "Transport": Theme.emojiArray = emojiTransport
            Theme.bgcolor = .systemBlue
        case "Plant": Theme.emojiArray = emojiPlant
            Theme.bgcolor = .systemGreen
        case "Sport": Theme.emojiArray = emojiSport
            Theme.bgcolor = .systemPurple
        default: Theme.emojiArray = emojiAnimal
        }
    }
}

//MARK: - Int extension for random generation
// Экстеншен для Int для генерации случайных чисел.

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
