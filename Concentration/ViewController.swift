//
//  ViewController.swift
//  Concentration
//
//  Created by Сергей Вялкин on 03.08.2021.
//

import UIKit

class ViewController: UIViewController {
    
    private var game: Concentration!
    
    private var theme: [String]!
    
    private let themes = [
        "sport": ["🏀", "🏒", "🥎", "🥊", "⛸", "🪂"],
        "animals": ["🐶", "🐵", "🐻", "🦊", "🐸", "🐔"],
        "faces": ["😀", "🧐", "😡", "😱", "🤢", "💩"],
        "nature": ["🌹", "🍂", "🍁", "🌿", "🍀", "🌲"],
        "astronomy": ["🌞", "🌘", "🌎", "🪐", "☄️", "💫", "🌔"],
        "weather": ["☀️", "🌤", "🌧", "❄️", "🌩", "🌈"]
    ]
    
    private var emoji: [Int:String]!
    
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    override func viewDidLoad() {
        startNewGame()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func touchCard(_ sender: UIButton) {
        if let buttonIndex = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: buttonIndex)
            updateViewFromModel()
        }
    }
    
    @IBAction func starNewGame(_ sender: UIButton) {
        startNewGame()
    }
    
    private var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    private func startNewGame() {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        initTheme()
        emoji = [Int:String]()
        updateViewFromModel()
    }
    
    private func initTheme() {
        theme = themes[themes.keys.randomElement()!]
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = .white
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? .clear : .orange
            }
        }
        updateFlipCountUi(flipCount: game.getFlipCount())
        updateScoreUi(score: game.getScore())
    }
    
    private func updateFlipCountUi(flipCount: Int) {
        flipCountLabel.text = "Flips \(flipCount)"
    }
    
    private func updateScoreUi(score: Int) {
        scoreLabel.text = "Score: \(score)"
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, theme.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(theme.count)))
            emoji[card.identifier] = theme.remove(at: randomIndex)
        }
        
        return emoji[card.identifier] ?? "?"
    }
}
