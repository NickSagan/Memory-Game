//
//  StartScreenViewController.swift
//  Memory Game
//
//  Created by Nick Sagan on 17.10.2021.
//

import UIKit

class StartScreenViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue){}
    var emoji = Theme()
    @IBOutlet weak var emojiThemePicker: UIPickerView!
    @IBOutlet weak var bestScoreLabel: UILabel!
    @IBOutlet weak var chosenThemeLabel: UILabel!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // PickerView needs this:
        emojiThemePicker.dataSource = self
        emojiThemePicker.delegate = self
        
        // Set default theme in case user will not chose any
        emoji.setTheme(set: "Food")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        emojiThemePicker.selectRow(2, inComponent: 0, animated: true)

        // Refreshing emoji array in case user will not chose any theme after New Game button pressed. And because viewDidLoad will not setTheme again anymore
        emoji.refreshEmojiArray()
        // Updating best score label
        bestScoreLabel.text = "Your best score: \(defaults.integer(forKey: "bestScore"))"
        var sampleEmoji = ""
        for i in 0...3 {
            sampleEmoji += Theme.emojiArray[i]
        }
        chosenThemeLabel.text = sampleEmoji
        chosenThemeLabel.adjustsFontSizeToFitWidth = true
        chosenThemeLabel.numberOfLines = 1
        chosenThemeLabel.lineBreakMode = .byClipping
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // Only one: to pick theme
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        // depends on number of possible themes (theme array)
        return emoji.theme.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        // Fullfill the pickerview with all the themes
        return emoji.theme[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        // returns chosen theme
        emoji.setTheme(set: emoji.theme[row])
        
        var sampleEmoji = ""
        for i in 0...3 {
            sampleEmoji += Theme.emojiArray[i]
        }
        chosenThemeLabel.text = sampleEmoji
    }
    
}
