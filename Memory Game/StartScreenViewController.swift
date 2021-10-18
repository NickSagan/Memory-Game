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
        emojiThemePicker.dataSource = self
        emojiThemePicker.delegate = self
        emoji.setTheme(set: "Animal")
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return emoji.theme.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return emoji.theme[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        emoji.setTheme(set: emoji.theme[row])
        //someMaybeLabel.text = emoji.theme[row]
    }
    
}
