//
//  Route.swift
//  TicketToRideRules
//
//  Created by Carlos Simon on 05/05/2019.
//  Copyright © 2019 AltApps. All rights reserved.
//

import Foundation

public struct Route{
    public let start: Station
    public let end: Station
    public let points: Int
    
    
    public init(start: Station, end: Station, points: Int){
        self.start = start
        self.end = end
        self.points = points
    }
}
