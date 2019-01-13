//
//  ViewController.swift
//  Concentration
//
//  Created by Nick Beznos on 1/10/19.
//  Copyright © 2019 Nick Beznos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    var flipCount = 0 {
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    var score = 0 {
        didSet{
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    @IBAction func newGameButton(_ sender: UIButton) {
        newGame()
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("this card was not in cardButtons")
        }

    }
    func updateViewFromModel() {
        for index in cardButtons.indices {
            //print(game.cards.count)
            let button = cardButtons[index]
            let card = game.cards[index] // трабл тут. Наверное, массив cards не заполняется элементами, как должен при инициализации объекта Сard.
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.9714247993, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.9714247993, blue: 0, alpha: 1)
                if card.isMatched {
                    score += 2
                } else {
                    score -= 1
                }
            }
        }
    }
  //  var emojiChoises = ["😁", "😍", "🧐", "☹️", "😤", "😱", "🤔", "🥴", "🤢"]
    var emojiChoises = [String]()

    

    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoises.count > 0 {
             let randomIndex = Int(arc4random_uniform(UInt32(emojiChoises.count)))
            emoji[card.identifier] = emojiChoises.remove(at: randomIndex)
             
        }
    
        return emoji[card.identifier] ?? "?"
    }
    
    func newGame() {
        flipCount = 0
        score = 0
        
        
        for index in cardButtons.indices {
            let button = cardButtons[index]
            button.backgroundColor = #colorLiteral(red: 1, green: 0.9714247993, blue: 0, alpha: 1)
        }
        let themeIndex = Int(arc4random_uniform(UInt32(5)))

        switch themeIndex {
        case 0: emojiChoises = ["😁", "😍", "🧐", "☹️", "😤", "😱", "🤔", "🥴", "🤢"]
        case 1: emojiChoises = ["🐶", "🐼", "🐵", "🐴", "🐰", "🐻", "🐮", "🐷", "🐔"]
        case 2: emojiChoises = ["🍏", "🍎", "🍐", "🍋", "🥥", "🍓", "🍉", "🥝", "🥭"]
        case 3: emojiChoises = ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🥏", "🎱"]
        case 4: emojiChoises = ["🚗", "🚕", "🏍", "🚌", "🚜", "🏎", "🚓", "🚑", "🚒"]
        case 5: emojiChoises = ["🧲", "💎", "🛠", "🧨", "🗝", "🔒", "📎", "📚", "💡"]
            
        default:
            break
            
        }
    }
    override func viewDidLoad() {
        
        
    }
}

