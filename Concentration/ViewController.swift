//
//  ViewController.swift
//  Concentration
//
//  Created by Nick Beznos on 1/10/19.
//  Copyright © 2019 Nick Beznos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var numberOfPairsOfCards: Int{
            return (cardButtons.count + 1) / 2
    }
    
    private var game: Concentration!
    
    var backColor = #colorLiteral(red: 1, green: 0.9714247993, blue: 0, alpha: 1)

    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBAction private func touchNewGame(_ sender: UIButton) { newGame() }
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("this card was not in cardButtons")
        }
    }
    
//    private func updateScoreAndFlipLabels() {
////        let attributes: [NSAttributedString.Key: Any] = [
////        .strokeWidth = 5.0,
////        .strokeColor = backColor]
//
//        let attributes: [NSAttributedString.Key: Any] = [
//            NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeWidth.rawValue): 5.0,
//            NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeColor.rawValue): backColor]
//        let attributedFlipCount = NSAttributedString(string: flipCountLabel.text!, attributes: attributes)
//        let attributedScore = NSAttributedString(string: scoreLabel.text!, attributes: attributes)
//    }
    
    private func updateViewFromModel() {
        scoreLabel.text = "Score: \(game.score)"
        flipCountLabel.text = "Flips: \(game.flipCount)"
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.9714247993, blue: 0, alpha: 0) : backColor
            }
        }
    }

    var emojiChoises = String()
    let themes = ["😁😍🧐☹️😤😱🤔🥴🤢", "🐶🐼🐵🐴🐰🐻🐮🐷🐔", "🍏🍎🍐🍋🥥🍓🍉🥝🥭", "⚽️🏀🏈⚾️🎾🏐🏉🥏🎱", "🚗🚕🏍🚌🚜🏎🚓🚑🚒"]
    let backGrounds = [[#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)],
                       [#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1)],
                       [#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)],
                       [#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)],
                       [#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), #colorLiteral(red: 0.1449589431, green: 0.148973316, blue: 0.1531212926, alpha: 1)]]
    var emoji = [Card:String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoises.count > 0 {
            let randomStringIndex = emojiChoises.index(emojiChoises.startIndex, offsetBy: emojiChoises.count.arc4random)
            emoji[card] = String(emojiChoises.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
    
    private func newGame() {
        let themeIndex = Int(arc4random_uniform(UInt32(themes.count)))
        
        emojiChoises = themes[themeIndex]
        view.backgroundColor = backGrounds[themeIndex][0]
        backColor = backGrounds[themeIndex][1]
        
        if view.backgroundColor == #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) || view.backgroundColor == #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1){
            UIApplication.shared.statusBarStyle = .lightContent
            setNeedsStatusBarAppearanceUpdate()
        } else {
            UIApplication.shared.statusBarStyle = .default
            setNeedsStatusBarAppearanceUpdate()
        }
       
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        updateViewFromModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newGame()
    }
}

extension Int {
    var arc4random: Int{
        if self > 0 {
            return Int(arc4random_uniform(UInt32(abs(self))))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
