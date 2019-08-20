//
//  Card.swift
//  Concentration
//
//  Created by Shoko Hashimoto on 2019-08-19.
//  Copyright © 2019 Shoko Hashimoto. All rights reserved.
//

import Foundation

// Difference between class and struct
// 1: Struct is no inheritence
// 2: Structs are Value types and Class are refirence types

struct Card: Hashable
{
    var hashValue: Int{ return identifier }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    private static var indirectFactory = 0
    
    private static func getUniquIdentifier() -> Int {
        indirectFactory += 1
        return indirectFactory
    }
    
    init() {
        self.identifier = Card.getUniquIdentifier()
    }
}
