//
//  LineCost.swift
//  TicketToRideRules
//
//  Created by Carlos Simon on 05/05/2019.
//  Copyright © 2019 AltApps. All rights reserved.
//

import Foundation

public struct LineCost: CustomStringConvertible{
    public var cardType: CardType?
    public var any: Bool
    
    public init(cardType: CardType){
        self.cardType = cardType
        self.any = false
    }
    public init(any: Bool = true){
        self.any = any
        self.cardType = nil
    }
    
    public var description: String{
        if self.cardType != nil{
            return self.cardType?.description ?? ""
        }else{
            return "*"
        }
    }
    
    public static func build(type: CardType, number: Int) -> [LineCost]{
        return Array(repeating: LineCost(cardType: type), count: number)
    }
    public static func build(anyWithNumberOfCards number: Int) -> [LineCost]{
        return Array(repeating: LineCost(any: true), count: number)
    }
}
