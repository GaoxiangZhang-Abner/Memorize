//
//  Array+Only.swift
//  Memorize
//
//  Created by Gaoxiang Zhang on 2020/9/23.
//  Copyright © 2020 Gaoxiang Zhang. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        return self.count == 1 ? self.first : nil
    }
}
