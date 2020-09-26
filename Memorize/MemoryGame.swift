//
//  MemoryGame.swift
//  Memorize
//
//  Created by Gaoxiang Zhang on 2020/9/18.
//  Copyright © 2020 Gaoxiang Zhang. All rights reserved.
//  Model模型

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        
        // 精简前的code
//        get {
//            // get之前,判断是否是正面的卡并且唯一
//            var faceUpCardIndex = [Int]()
//
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    faceUpCardIndex.append(index)
//                }
//            }
//
//            if faceUpCardIndex.count == 1 {
//                return faceUpCardIndex.first
//            } else {
//                return nil
//            }
//        }
//
//        set {
//            // set之后,点击卡片后,对于此卡翻到正面,其余反面
//            for index in cards.indices {
//                cards[index].isFaceUp = (index == newValue)
//                if index == newValue ? cards[index].isFaceUp :
//                    cards[index].isFaceUp = true
//                } else {
//                    cards[index].isFaceUp = false
//                }
//            }
//        }
        
        // 精简后的code
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func choose(card: Card) { // card是struct的类型，它是值拷贝，所以这里的card不是Array中的card
        print("Choose the card: \(card)")

        if let choosenIndex = cards.firstIndex(macthing: card), !cards[choosenIndex].isFaceUp, !cards[choosenIndex].isMatched {
            if let potentialMatchIndex = indexOfOneAndOnlyFaceUpCard {
                if cards[choosenIndex].content == cards[potentialMatchIndex].content {
                    cards[choosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                // indexOfOneAndOnlyFaceUpCard = nil
                cards[choosenIndex].isFaceUp = !cards[choosenIndex].isFaceUp
            } else {
                indexOfOneAndOnlyFaceUpCard = choosenIndex
            }
        }
    }

    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for index in 0 ..< numberOfPairsOfCards {
            let content = cardContentFactory(index)
            cards.append(Card(id: index * 2, content: content))
            cards.append(Card(id: index * 2 + 1, content: content))
        }
    }
    
    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
}
