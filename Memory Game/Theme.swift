//
//  Theme.swift
//  Memory Game
//
//  Created by Nick Sagan on 17.10.2021.
//

import UIKit

class Theme {
    
    var theme = ["Животные", "Фрукты", "Еда", "Транспорт", "Растения", "Спорт"]
    private var selectedTheme = "Животные"
    static var backgroundColor: UIColor = .systemBlue
    static var cardBackColor: UIColor = .systemBlue
    static var cardFrontColor: UIColor = .systemBlue
    
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
    
    private static var emoji = [Card:String]()
    static var emojiArray = [String]()
    
    func getEmoji(forCard card: Card) -> String {
        if Theme.emoji[card] == nil, Theme.emojiArray.count > 0 {
            Theme.emoji[card] = Theme.emojiArray.remove(at: Theme.emojiArray.count.arc4random)
        }
        return Theme.emoji[card] ?? "?"
    }
    
    func refreshEmojiArray() {
        switch selectedTheme {
        case "Животные": Theme.emojiArray = emojiAnimal
            Theme.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.7764705882, blue: 0.6470588235, alpha: 1)
            Theme.cardBackColor = #colorLiteral(red: 1, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
            Theme.cardFrontColor = #colorLiteral(red: 0.9529411765, green: 0.9411764706, blue: 0.8431372549, alpha: 1)
        case "Фрукты": Theme.emojiArray = emojiFruit
            Theme.backgroundColor = #colorLiteral(red: 0.8078431373, green: 0.8980392157, blue: 0.8156862745, alpha: 1)
            Theme.cardBackColor = #colorLiteral(red: 1, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
            Theme.cardFrontColor = #colorLiteral(red: 0.9529411765, green: 0.9411764706, blue: 0.8431372549, alpha: 1)
        case "Еда": Theme.emojiArray = emojiFood
            Theme.backgroundColor = #colorLiteral(red: 0.4235294118, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
            Theme.cardBackColor = #colorLiteral(red: 0.7843137255, green: 0.5843137255, blue: 0.5843137255, alpha: 1)
            Theme.cardFrontColor = #colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)
        case "Транспорт": Theme.emojiArray = emojiTransport
            Theme.backgroundColor = .systemGray
            Theme.cardBackColor = #colorLiteral(red: 1, green: 0.5254901961, blue: 0.368627451, alpha: 1)
            Theme.cardFrontColor = #colorLiteral(red: 0.9960784314, green: 0.9764705882, blue: 0.937254902, alpha: 1)
        case "Растения": Theme.emojiArray = emojiPlant
            Theme.backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.3176470588, blue: 0.1568627451, alpha: 1)
            Theme.cardBackColor = #colorLiteral(red: 0.3058823529, green: 0.6235294118, blue: 0.2392156863, alpha: 1)
            Theme.cardFrontColor = #colorLiteral(red: 0.8470588235, green: 0.9137254902, blue: 0.6588235294, alpha: 1)
        case "Спорт": Theme.emojiArray = emojiSport
            Theme.backgroundColor = #colorLiteral(red: 0.4274509804, green: 0.5960784314, blue: 0.5254901961, alpha: 1)
            Theme.cardBackColor = #colorLiteral(red: 0.8509803922, green: 0.7921568627, blue: 0.7019607843, alpha: 1)
            Theme.cardFrontColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        default: Theme.emojiArray = emojiAnimal
        }
        print(Theme.emojiArray)
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
