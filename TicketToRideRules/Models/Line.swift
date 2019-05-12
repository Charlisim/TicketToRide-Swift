//
//  Line.swift
//  TicketToRideRules
//
//  Created by Carlos Simon on 05/05/2019.
//  Copyright © 2019 AltApps. All rights reserved.
//

import Foundation

public struct Line: Equatable, CustomStringConvertible, Hashable{
    public static func == (lhs: Line, rhs: Line) -> Bool {
        let equalStart = lhs.start == rhs.start || lhs.start == rhs.end
        return equalStart && (lhs.end == rhs.end || lhs.end == rhs.start)
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(start)
        hasher.combine(end)
    }
    
    public var start: Station
    public var end: Station
    public var cost: [LineCost]
    public var isTunnel: Bool = false
    public var isAllAny: Bool{
        return self.cost.filter({ $0.any == true}).count == self.cost.count
    }
    public var numberAnyCards: Int{
        return self.cost.filter({ $0.any == true}).count
    }
    public var weight: Double{
        return Double(self.cost.count)
    }
    public var source: Station{
        return self.start
    }
    public var destination: Station{
        return self.end
    }
    public var description: String{
        let cost = "[\(self.cost.map({ $0.description}).joined(separator: "-"))]"
        
        return "From:\(self.start) - To: \(self.end)"
    }
    
    public init(start: Station, end:Station, cost:[LineCost], isTunnel: Bool = false){
        self.start = start
        self.end = end
        self.cost = cost
        self.isTunnel = isTunnel        
    }
}


