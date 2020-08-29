//
//  ContentView.swift
//  Memorize
//
//  Created by Gaoxiang Zhang on 2020/9/1.
//  Copyright © 2020 Gaoxiang Zhang. All rights reserved.
//

import SwiftUI

// keyword is megenta (洋红)
// name of identifier is green
// Swift's identifier is purple
// ContentView behavies like a view (not 'is a view') because it is not OOP, it's functional programming
struct ContentView: View { // curly brace (花括号)
    
    // some mean the variable body is any type, any struct which behavies like a View
    // 即body不论什么type，只要它表现得像个View
    var body: some View { // 此处var的value没有存储在内存中，而是在向var取值时计算curly brace中的内容并return
        return Text("Hello, World!") // in parentheses 括号中
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
