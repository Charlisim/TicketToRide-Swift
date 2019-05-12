//
//  Pile.swift
//  TicketToRideRules
//
//  Created by Carlos Simon on 05/05/2019.
//  Copyright © 2019 AltApps. All rights reserved.
//

import Foundation

public protocol CardPile{
    var cards: [Card] { get set }
    init()
    init(cards:[Card])
    init(cardTypes:[CardType])
    mutating func add(card:Card)
    
}
public extension CardPile{
    
    init(cards: [Card]) {
        self.init()
        self.cards = cards
    }
    init(cardTypes: [CardType]) {
        self.init()
        self.cards = cardTypes.map(Card.init)
    }
}
