//
//  Cardify.swift
//  Memorize
//
//  Created by Gaoxiang Zhang on 2020/9/25.
//  Copyright © 2020 Gaoxiang Zhang. All rights reserved.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var rotation: Double
    
    init(isFaceUp: Bool) {
        self.rotation = isFaceUp ? 0 : 180
    }
    
    var isFaceUp: Bool {
        rotation < 90 // rotation < 90 的时候都是true
    }
    
    var animatableData: Double { // 不断跟踪rotation
        get { return rotation }
        set { rotation = newValue }
    }
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3.0
    
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                content
            }
            .opacity(isFaceUp ? 1 : 0)
            
            RoundedRectangle(cornerRadius: cornerRadius).fill()
            .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(
            Angle(degrees: rotation),
            axis: (0, 1, 0)
        )
    }
    
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
