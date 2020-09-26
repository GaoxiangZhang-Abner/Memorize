//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Gaoxiang Zhang on 2020/9/1.
//  Copyright © 2020 Gaoxiang Zhang. All rights reserved.
//

// keyword is megenta (洋红)
// name of identifier is green
// Swift's identifier is purple
// ContentView behavies like a view (not 'is a view') because it is not OOP, it's functional programming
// { } curly brace (花括号)

// some mean the variable body is any type, any struct which behavies like a View
// 即body不论什么type，只要它表现得像个View
// 此处var的value没有存储在内存中，而是在向var取值时计算curly brace中的内容并return
// var body: some View {
//      Text("Hello, World!") // in parentheses 括号中
// }

//  View视图

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        Grid(viewModel.cards) { card in
            CardView(card: card).onTapGesture {
                viewModel.choose(card: card)
            }
            .padding(5)
        }
        .padding()
        .foregroundColor(Color.orange)
    }
}

struct CardView: View {
    // 这里仅表明类型，不代表实例
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            body(for: geometry.size)
        }
    }
    
    // ViewBuilder返回一系列子视图，若没有返回则默认返回空
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(0), clockwise: true) // Swift中坐标轴向下向右，y和x变大，所以顺时针和逆时针相反
                    .padding(5).opacity(0.4)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    // MARK: - Drawing Constants
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
        
    }
}


