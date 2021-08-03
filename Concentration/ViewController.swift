//
//  ViewController.swift
//  Concentration
//
//  Created by Сергей Вялкин on 03.08.2021.
//

import UIKit

class ViewController: UIViewController {
    
    private var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips \(flipCount)"
        }
    }
    
    private let emojiChoices = ["👻", "🎃"]
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        
        if let buttonIndex = cardButtons.firstIndex(of: sender) {
            let emoji = emojiChoices[buttonIndex % 2]
            flipCard(withEmoji: emoji, on: sender)
        }
    }
    
    private func flipCard(withEmoji emoji: String, on button: UIButton) {
        if (button.currentTitle == emoji) {
            button.setTitle("", for: .normal)
            button.backgroundColor = .orange
        } else {
            button.setTitle(emoji, for: .normal)
            button.backgroundColor = .white
        }
    }
}
