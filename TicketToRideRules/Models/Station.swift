//
//  Station.swift
//  TicketToRideRules
//
//  Created by Carlos Simon on 05/05/2019.
//  Copyright © 2019 AltApps. All rights reserved.
//

import Foundation

public struct Station: Hashable, CustomStringConvertible{
    public var index: Int
    public var name: String
    
    public var description: String{
        return self.name
    }
    
    public init(index: Int = 0, element: String){
        self.index = index
        self.name = element
    }
    public init(name: String){
        self.index = 0
        self.name = name
    }
}
