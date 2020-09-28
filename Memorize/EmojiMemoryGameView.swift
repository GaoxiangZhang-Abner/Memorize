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
        VStack {
            
            // Card
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration: 0.75)) {
                        viewModel.choose(card: card)
                    }
                }
                .padding(5)
            }
            .padding()
            .foregroundColor(Color.orange)
            
            // Button
            Button(action: {
                withAnimation(.easeInOut) {
                    viewModel.resetGame()
                }
            }, label: { Text("New Game") })
        }
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
    
    // @State: View中需要一些临时的非readOnly的变量
    @State private var animatedBonusRemaining: Double = 0
    
    func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    // ViewBuilder返回一系列子视图，若没有返回则默认返回空
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                
                // 计时派
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockwise: true) // Swift中坐标轴向下向右，y和x变大，所以顺时针和逆时针相反
                            .onAppear { // Pie出现时调用的方法
                                startBonusTimeAnimation()
                            }
                    } else {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90), clockwise: true) // Swift中坐标轴向下向右，y和x变大，所以顺时针和逆时针相反
                    }
                }
                .padding(5).opacity(0.4)
                .transition(.identity)
                
                // 内容
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle(degrees: card.isMatched ? 360 : 0))
                    .animation(Animation.linear(duration: 0.5).repeatForever(autoreverses: false))
                
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
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


