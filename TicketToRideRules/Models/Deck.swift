//
//  Deck.swift
//  TicketToRideRules
//
//  Created by Carlos Simon on 05/05/2019.
//  Copyright © 2019 AltApps. All rights reserved.
//

import Foundation
import GameplayKit

public struct Deck{
    public var cards:[Card] = []
    
    public init(rules: [CardType: Int]){
        self.cards = rules.flatMap { (rule) -> [Card] in
            return Array(repeating: Card(type: rule.key), count: rule.value)
        }
    }
    public mutating func shuffle(){
        let random = GKLinearCongruentialRandomSource(seed: 11)
        self.cards = random.arrayByShufflingObjects(in: self.cards) as? [Card] ?? self.cards
    }
    public var remainingNumberCards: Int{
        return self.cards.count
    }
    public mutating func pop() -> Card?{
        return self.cards.popLast()
    }
}
