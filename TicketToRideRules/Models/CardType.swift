//
//  CardType.swift
//  TicketToRideRules
//
//  Created by Carlos Simon on 05/05/2019.
//  Copyright © 2019 AltApps. All rights reserved.
//

import Foundation

public enum CardType: String, CaseIterable, CustomStringConvertible{
    case red
    case white
    case yellow
    case green
    case locomotive
    case black
    case blue
    case orange
    case pink
    
    public var description: String{
        return self.rawValue.capitalized
    }
}
