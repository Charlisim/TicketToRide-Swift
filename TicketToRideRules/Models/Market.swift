//
//  Market.swift
//  TicketToRideRules
//
//  Created by Carlos Simon on 05/05/2019.
//  Copyright © 2019 AltApps. All rights reserved.
//

import Foundation

public struct Market: CardPile{
    public var cards: [Card]
    
    public init() {
        self.cards = []
    }
    public mutating func add(card:Card){
        self.cards.append(card)
    }
    public func hasCard(type: CardType) -> Bool {
        return self.cards.contains(where: { $0.type == type })
    }
    
    public mutating func popCard(ofType type: CardType) -> Card? {
        guard let index = self.cards.firstIndex(where: { $0.type == type}) else{
            return nil
        }
        return self.cards.remove(at: index)
    }
    public func numberOfCards(ofType type: CardType) -> Int{
        return self.cards.filter({ $0.type == type}).count
    }
    public func hasReachLimit() -> Bool{
        return self.cards.count >= 5
    }
}
