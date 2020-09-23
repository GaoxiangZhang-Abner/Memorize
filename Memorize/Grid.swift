//
//  Grid.swift
//  Memorize
//
//  Created by Gaoxiang Zhang on 2020/9/23.
//  Copyright © 2020 Gaoxiang Zhang. All rights reserved.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    
    var items: [Item]
    var viewForItem: (Item) -> ItemView
    
    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        GeometryReader { geometry in
            ForEach(items) { item in
                body(for: item, in: GridLayout(itemCount: items.count, in: geometry.size))
            }
        }
    }
    
    func body(for item: Item, in layout: GridLayout) -> some View {
        let index = items.firstIndex(macthing: item)
        return Group {
            if index != nil {
                viewForItem(item)
                    .frame(width: layout.itemSize.width, height: layout.itemSize.height)
                    .position(layout.location(ofItemAt: index!))
            }
        }
    }

}

