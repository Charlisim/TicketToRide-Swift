//
//  Movement.swift
//  TicketToRideRules
//
//  Created by Carlos Simon on 05/05/2019.
//  Copyright © 2019 AltApps. All rights reserved.
//

import Foundation


public struct Movement{
    public enum Result{
        case canBuildWithHand
        case canBuildTakingMarket
        case needToRequestForTunnel
        case takingMarketHelps
        case none
        
        var priority: Int{
            switch self {
            case .canBuildWithHand:
                return 1
            case .canBuildTakingMarket:
                return 2
            case .needToRequestForTunnel:
                return 1
            case .takingMarketHelps:
                return 3
            default:
                return 4
            }
        }
        
    }
    struct MatchingResult{
        let cardType: CardType
        let needs: Int
    }
    public init(){
        
    }
    public func calculateBuild(_ line:Line, withCardsInHand hand: Hand, market: Market) -> Movement.Result{
        if self.canBuildLine(line, withCardsInHand: hand){
            return .canBuildWithHand
        }
        let neededCards = self.getNeededCards(forLine: line, withHand: hand)
        if neededCards.isEmpty{
            return .none
        }
        let matchingCardsInMarket:[CardType: Int] = neededCards.map({ ($0.cardType,market.numberOfCards(ofType: $0.cardType))}).reduce([:]) { (dict, tuple) -> [CardType: Int] in
            var updatedDict = dict
            updatedDict[tuple.0] = tuple.1
            return updatedDict
        }
        let matchinNeededCards:[Movement.Result] = neededCards.map { (matchingResult) -> Movement.Result in
            if matchingCardsInMarket[matchingResult.cardType] ?? 0 >= matchingResult.needs{
                return .canBuildTakingMarket
            } else if matchingCardsInMarket[matchingResult.cardType] == 0{
                return .none
            }
            return .takingMarketHelps
        }
        let sortedResults =  matchinNeededCards.sorted(by: { (result1, result2) -> Bool in
            return result1.priority < result2.priority
        })
        
        return sortedResults.first ?? .none
    }
    func canBuildLine(_ line: Line, withCardsInHand hand: Hand) -> Bool{
        var canBuild: Bool = true
        if line.numberAnyCards > 0{
            let cardsNeeded = line.numberAnyCards
            canBuild = CardType.allCases.map { (cardType) -> Bool in
                return hand.has(cardsNeeded, cardOfType: cardType)
                }.contains(true)
        }
       
        
        let lineSet = line.cost.compactMap({ $0.cardType })
        guard !lineSet.isEmpty else{
            return canBuild
        }
        let handSet = hand.cards.compactMap({ $0.type })
        var bin:[CardType] = []
        for element in handSet where lineSet.contains(element) || element == .locomotive{
            bin.append(element)
        }
        return bin.count >= lineSet.count && canBuild
    }
    func getNeededCards(forLine line: Line, withHand hand: Hand) -> [MatchingResult]{
        var possibleCombinations:[MatchingResult] = []
        if line.numberAnyCards > 0{
            let cardsNeeded = line.numberAnyCards
            possibleCombinations = CardType.allCases.compactMap { (cardType) -> MatchingResult? in
                let handCards = hand.numberOfCards(ofType: cardType)
                let neededCardsOfType = max(cardsNeeded - handCards, 0)
                if neededCardsOfType == 0 { return nil }
                return MatchingResult(cardType: cardType, needs: neededCardsOfType)
            }
        }
        
        let lineSet = line.cost.compactMap({ $0.cardType })
        let handSet = hand.cards.compactMap({ $0.type })
        var bin:[CardType] = []
        for element in handSet where lineSet.contains(element) || element == .locomotive{
            bin.append(element)
        }
        guard !lineSet.isEmpty else{
            return possibleCombinations
        }
        let neededCards = lineSet.count - bin.count
        guard let cardTypeNeeded = lineSet.first else{
            return possibleCombinations
        }
        
        return [MatchingResult(cardType: .locomotive, needs: neededCards), MatchingResult(cardType: cardTypeNeeded, needs: neededCards)]
        
    }
}
