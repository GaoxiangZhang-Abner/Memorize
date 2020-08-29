//
//  ContentView.swift
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

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            ForEach(0..<3) { index in
                CardView(isFaceUp: true)
            }
        }
        .padding()
        .foregroundColor(Color.orange)
        .font(Font.largeTitle)
    }
}

struct CardView: View {
    var isFaceUp: Bool
    
    var body: some View {
        ZStack {
            if (isFaceUp) {
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3.0)
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                Text("🐶")
            } else {
                RoundedRectangle(cornerRadius: 10.0).fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
