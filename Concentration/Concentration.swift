//
//  Concentration.swift
//  Concentration
//
//  Created by Nick Beznos on 1/11/19.
//  Copyright © 2019 Nick Beznos. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card] ()
    var indexOfOneAndOnlyFaceUpCard: Int?
    var score = 0
    var flipCount = 0
    
    func chooseCard(at index: Int) {
        
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
            indexOfOneAndOnlyFaceUpCard = nil
            
        } else {
            
            for flipDownIndex in cards.indices {
                cards[flipDownIndex].isFaceUp = false
                
            }
            cards[index].isFaceUp = true
            indexOfOneAndOnlyFaceUpCard = index
        }
    }
    init (numberOfPairsOfCards: Int){
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
            for _ in cards {
                cards.append(cards.remove(at: Int(arc4random_uniform(UInt32(cards.count)))))
                // кидаю в конец случайную карту
            }
        }
        
    }
}
