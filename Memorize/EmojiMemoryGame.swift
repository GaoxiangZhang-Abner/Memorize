//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Gaoxiang Zhang on 2020/9/21.
//  Copyright © 2020 Gaoxiang Zhang. All rights reserved.
//  ViewModel视图模型

import Foundation

class EmojiMemoryGame: ObservableObject {
    
    // @Publisher 表示当变量改变的时候，就会执行ObjectWillChange.send()方向，重绘UI
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static private func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["👻","🤯","🤩"]
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
    
    func resetGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
    
}
