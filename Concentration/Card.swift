//
//  Card.swift
//  Concentration
//
//  Created by Сергей Вялкин on 04.08.2021.
//

import Foundation

struct Card {
    
    var isFaceUp = false
    var isMatched = false
    var isPreviouslySeen = false
    
    private var identifier: Int
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    func match(withOther card: Card) -> Bool {
        return self.identifier == card.identifier
    }
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    private static var identifierFactory = 0
}
