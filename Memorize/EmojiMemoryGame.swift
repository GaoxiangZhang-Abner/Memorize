//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Gaoxiang Zhang on 2020/9/21.
//  Copyright © 2020 Gaoxiang Zhang. All rights reserved.
//

import Foundation

class EmojiMemoryGame {
    
    private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["🥳","🤯","🤩"]
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { index in
            emojis[index]
        }
    }
    
    // MARK: - Access to the Model
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
}
