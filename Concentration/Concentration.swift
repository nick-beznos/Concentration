//
//  Concentration.swift
//  Concentration
//
//  Created by Nick Beznos on 1/11/19.
//  Copyright © 2019 Nick Beznos. All rights reserved.
//

import Foundation

class Concentration {
    private(set) var cards = [Card] ()
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex:Int?
            for index in cards.indices {
                if cards[index].isFaceUp{
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    private(set) var score = 0
    private(set) var flipCount = 0
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index is not in cards")
        if cards[index].isMatched {
            return
        } else {
             flipCount += 1
        }
        
        
        if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
            
            
            if cards[matchIndex].identifier == cards[index].identifier {
                cards[matchIndex].isMatched = true
                cards[index].isMatched = true
                score += 2
            } else {
                if cards[index].flipped{
                    score -= 1
                }
                if cards[matchIndex].flipped{
                    score -= 1
                }
            }
            cards[index].isFaceUp = true
            cards[index].flipped = true
            cards[matchIndex].flipped = true
        } else {
            indexOfOneAndOnlyFaceUpCard = index
        }
    }
    init (numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): there must be at list 1 pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
            for _ in cards {
                cards.append(cards.remove(at: Int(arc4random_uniform(UInt32(cards.count)))))
            }
        }
        
    }
}
