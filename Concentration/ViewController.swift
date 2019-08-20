//
//  ViewController.swift
//  Concentration
//
//  Created by Shoko Hashimoto on 2019-08-19.
//  Copyright © 2019 Shoko Hashimoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: namberOfPairsOfCards)
    
    var namberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    private(set) var flipCount = 0 {
        didSet{
            updateFlipCountLabale()
        }
    }
    
    private func updateFlipCountLabale(){
        let attributes: [NSAttributedString.Key:Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        filpCountLabel.attributedText = attributedString
    }
    
    @IBOutlet private weak var filpCountLabel: UILabel! {
        didSet {
            updateFlipCountLabale()
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
        
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            }
        }
    }
    
//    private var emojiChoices: Array<String> = ["🦇","😲","🙀","😈","🎃","👻","🍭","🍬","🍎"]
    private var emojiChoices = "🦇😲🙀😈🎃👻🍭🍬🍎"
    
    
    private var emoji = [Card:String]() // Dictionaly
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int( arc4random_uniform(UInt32(self)) )
        } else if self < 0 {
            return -Int( arc4random_uniform(UInt32(abs(self))) )
        } else {
            return 0
        }
    }
}

