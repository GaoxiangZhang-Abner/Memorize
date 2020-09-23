//
//  Array+identifiable.swift
//  Memorize
//
//  Created by Gaoxiang Zhang on 2020/9/23.
//  Copyright © 2020 Gaoxiang Zhang. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(macthing item: Element) -> Int? {
        for index in 0 ..< self.count {
            if self[index].id == item.id {
                return index
            }
        }
        return nil
    }
}
