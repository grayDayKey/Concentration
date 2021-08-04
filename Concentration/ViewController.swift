//
//  ViewController.swift
//  Concentration
//
//  Created by Сергей Вялкин on 03.08.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var game: Concentration!
    private var emojiChoices: [String]!
    
    private var emoji: [Int:String]!
    
    private var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    override func viewDidLoad() {
        startNewGame()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let buttonIndex = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: buttonIndex)
            updateViewFromModel()
        }
    }
    
    @IBAction func starNewGame(_ sender: UIButton) {
        startNewGame()
    }
    
    private func getNumberOfPairsOfCards() -> Int {
        return (cardButtons.count + 1) / 2
    }
    
    private func startNewGame() {
        game = Concentration(numberOfPairsOfCards: getNumberOfPairsOfCards())
        emojiChoices = ["👻", "🎃", "💀", "🙀", "🦊", "🐸"]
        emoji = [Int:String]()
        flipCount = 0
        updateViewFromModel()
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
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}
