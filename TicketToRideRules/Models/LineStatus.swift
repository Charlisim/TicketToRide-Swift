//
//  LineStatus.swift
//  TicketToRideRules
//
//  Created by Carlos Simon on 07/05/2019.
//  Copyright © 2019 AltApps. All rights reserved.
//

import Foundation

public struct LineStatus: Hashable{
    public static func == (lhs: LineStatus, rhs: LineStatus) -> Bool {
        return lhs.line == rhs.line
    }
    
    public enum Status{
        case free
        case ocuppied(player: Player)
    }
    public let line: Line
    public let status: Status
    
    init(line: Line, status: Status = .free){
        self.line = line
        self.status = status
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(line)
    }
    
}
