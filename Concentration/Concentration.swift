//
//  Concentration.swift
//  Concentration
//
//  Created by Сергей Вялкин on 04.08.2021.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int? {
        
        get {
            let onlyFaceUpCardsIndecies = cards.indices.filter { cards[$0].isFaceUp }
            
            return onlyFaceUpCardsIndecies.count == 1 ? onlyFaceUpCardsIndecies.first : nil
        }
        
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    private var score: Int = 0
    
    private var flipCount: Int = 0
    
    func getFlipCount() -> Int {
        return flipCount
    }
    
    func getScore() -> Int {
        return score
    }
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if !checkIfOnlyOneCardFaceUp(chosenCardAt: index) {
                
                if let matchIndex = indexOfOneAndOnlyFaceUpCard {
                    
                    if (match(cardAt: index, withAnotherCardAt: matchIndex)) {
                        onMatch(ofCardAt: index, withAnotherCardAt: matchIndex)
                    } else {
                        onMismatch(ofCardAt: index, withAnotherCardAt: matchIndex)
                    }
                    
                    faceUpOneCard(at: index)
                    markCardAsSeen(at: matchIndex)
                }
                
                markCardAsSeen(at: index)
                
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
            incrementFlipCount()
        }
    }
    
    
    private func incrementFlipCount() {
        flipCount += 1
    }
    
    private func incrementScore() {
        score += 2
    }
    
    private func decrementScore() {
        score -= 1
    }
    
    private func markCardAsSeen(at index: Int) {
        cards[index].isPreviouslySeen = true
    }
    
    private func checkIfOnlyOneCardFaceUp(chosenCardAt index: Int) -> Bool {
        if let matchIndex = indexOfOneAndOnlyFaceUpCard {
            return matchIndex == index
        }
        
        return true
    }
    
    private func match(cardAt index: Int, withAnotherCardAt anotherIndex: Int) -> Bool {
        return cards[index].identifier == cards[anotherIndex].identifier
    }
    
    private func onMatch(ofCardAt index: Int, withAnotherCardAt anotherIndex: Int) {
        cards[index].isMatched = true
        cards[anotherIndex].isMatched = true
        incrementScore()
    }
    
    private func onMismatch(ofCardAt index: Int, withAnotherCardAt anotherIndex: Int) {
        if (cards[index].isPreviouslySeen || cards[anotherIndex].isPreviouslySeen) {
            decrementScore()
        }
    }
    
    private func flipDownAllCards() {
        // no cards or 2 cards are face up
        for flipDownIndex in cards.indices {
            cards[flipDownIndex].isFaceUp = false
        }
    }
    
    private func faceUpOneCard(at index: Int) {
        cards[index].isFaceUp = true
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}
