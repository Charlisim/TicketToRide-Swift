//
//  Hand.swift
//  TicketToRideRules
//
//  Created by Carlos Simon on 05/05/2019.
//  Copyright © 2019 AltApps. All rights reserved.
//

import Foundation


public struct Hand: CardPile{
    public init() {
        self.cards = []
    }
    
    public var cards: [Card]

    public mutating func add(card:Card){
        self.cards.append(card)
    }
    
    public func hasCard(ofType type: CardType) -> Bool {
        return self.has(1, cardOfType: type)
    }
    public func has(_ number: Int, cardOfType type: CardType) -> Bool{
        return self.numberOfCards(ofType: type) == number
    }
    public func numberOfCards(ofType type: CardType) -> Int{
        return self.cards.filter({ $0.type == type}).count
    }
    
}
