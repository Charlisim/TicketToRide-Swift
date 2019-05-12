//
//  Player.swift
//  TicketToRideRules
//
//  Created by Carlos Simon on 07/05/2019.
//  Copyright © 2019 AltApps. All rights reserved.
//

import Foundation


public struct Player{
    public var name: String
    public var hand: Hand
    public var routes: [Route]
    public var trains: Int

    public init(name: String, numberOfTrains: Int = 45){
        self.name = name
        self.hand = Hand()
        self.routes = []
        self.trains = numberOfTrains
    }
}
