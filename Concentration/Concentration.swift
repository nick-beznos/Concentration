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
    
    func chooseCard(at index: Int) {
        if !cards[index] .isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
                
            } else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    init (numberOfPairsOfCards: Int){
        for _ in 1..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        // TODO: Shuffle the cards
        //cards.shuffle()
    }
}
