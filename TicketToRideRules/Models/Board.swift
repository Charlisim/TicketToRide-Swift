//
//  Board.swift
//  TicketToRideRules
//
//  Created by Carlos Simon on 05/05/2019.
//  Copyright © 2019 AltApps. All rights reserved.
//

import Foundation


public struct Board{
    var stationList: AdjacencyList = AdjacencyList()
    
    public var graph: AdjacencyList{
        return stationList
    }
    public var stations: [Station] {
        return self.stationList.vertices
    }
    public var lines: Set<Line> = Set()
    @discardableResult mutating public func addStation(_ station: Station) -> Station{
        return self.stationList.addVertex(station)
    }
    mutating public func addLine(_ line: Line){
        self.stationList.add(line)
        self.lines.insert(line)
    }
    
    public init(){
        
    }
    
}
