//
//  StartScreenViewController.swift
//  Memory Game
//
//  Created by Nick Sagan on 17.10.2021.
//

import UIKit

class StartScreenViewController: UITableViewController {

    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue){}
    var emoji = Theme()
    @IBOutlet weak var bestScoreLabel: UILabel!
    @IBOutlet weak var chosenThemeLabel: UILabel!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        emoji.setTheme()
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

}
