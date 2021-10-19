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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // PickerView needs this:
        emojiThemePicker.dataSource = self
        emojiThemePicker.delegate = self
        
        // Set default theme in case user will not chose any
        emoji.setTheme(set: "Animals")
        view.backgroundColor = Theme.backgroundColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Refreshing emoji array in case user will not chose any theme after New Game button pressed. And because viewDidLoad will not setTheme again anymore
        emoji.refreshEmojiArray()
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
        // set bgcolor, depends on theme
        view.backgroundColor = Theme.backgroundColor
        //someMaybeLabel.text = emoji.theme[row]
    }
    
}
