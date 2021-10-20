//
//  Theme.swift
//  Memory Game
//
//  Created by Nick Sagan on 17.10.2021.
//

import UIKit

class Theme {
    
    var theme = ["Animals", "Fruits", "Food", "Transport", "Plants", "Sport"]
    private var selectedTheme = "Animals"
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
        case "Animals": Theme.emojiArray = emojiAnimal
            Theme.cardBackColor = #colorLiteral(red: 0.7843137255, green: 0.5843137255, blue: 0.5843137255, alpha: 1)
            Theme.cardFrontColor = #colorLiteral(red: 0.9529411765, green: 0.9411764706, blue: 0.8431372549, alpha: 1)
        case "Fruits": Theme.emojiArray = emojiFruit
            Theme.cardBackColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
            Theme.cardFrontColor = #colorLiteral(red: 0.9529411765, green: 0.9411764706, blue: 0.8431372549, alpha: 1)
        case "Food": Theme.emojiArray = emojiFood
            Theme.cardBackColor = #colorLiteral(red: 0.7843137255, green: 0.5843137255, blue: 0.5843137255, alpha: 1)
            Theme.cardFrontColor = #colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)
        case "Transport": Theme.emojiArray = emojiTransport
            Theme.cardBackColor = #colorLiteral(red: 1, green: 0.5254901961, blue: 0.368627451, alpha: 1)
            Theme.cardFrontColor = #colorLiteral(red: 0.9960784314, green: 0.9764705882, blue: 0.937254902, alpha: 1)
        case "Plants": Theme.emojiArray = emojiPlant
            Theme.cardBackColor = .systemGreen
            Theme.cardFrontColor = #colorLiteral(red: 0.8470588235, green: 0.9137254902, blue: 0.6588235294, alpha: 1)
        case "Sport": Theme.emojiArray = emojiSport
            Theme.cardBackColor = #colorLiteral(red: 0.8509803922, green: 0.7921568627, blue: 0.7019607843, alpha: 1)
            Theme.cardFrontColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        default: Theme.emojiArray = emojiAnimal
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
