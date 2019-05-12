//
//  Card.swift
//  TicketToRideRules
//
//  Created by Carlos Simon on 05/05/2019.
//  Copyright © 2019 AltApps. All rights reserved.
//

import Foundation

public struct Card: Equatable, CustomStringConvertible{
    public let type: CardType
    
    public var description: String{
        return self.type.description
    }
    public init(type: CardType) {
        self.type = type
    }
}
