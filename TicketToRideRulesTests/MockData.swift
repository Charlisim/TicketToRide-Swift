//
//  MockData.swift
//  TicketToRideRulesTests
//
//  Created by Carlos Simon on 09/05/2019.
//  Copyright © 2019 AltApps. All rights reserved.
//

import Foundation
import TicketToRideRules

class MockData{
    static func buildPlayer(name:String) -> Player{
        return Player(name: name)
    }
    static func buildBoard() -> (Board, [Line], [Station], [Route]){
        var board = Board()
        let cadiz = board.addStation(Station(name: "Cadiz"))
        let madrid = board.addStation(Station(name: "Madrid"))
        let lisboa = board.addStation(Station(name: "Lisboa"))
        let barcelona = board.addStation(Station(name: "Barcelona"))
        let pamplona = board.addStation(Station(name: "Pamplona"))
        let paris = board.addStation(Station(name: "Paris"))
        let marsella = board.addStation(Station(name: "Marsella"))
        let zurich = board.addStation(Station(name: "Zurich"))
        let brest = board.addStation(Station(name: "Brest"))
        let diepe = board.addStation(Station(name: "Diepe"))
        let london = board.addStation(Station(name: "London"))
        let edinburg = board.addStation(Station(name: "Edinburg"))
        let amsterdam = board.addStation(Station(name: "Amsterdam"))
        let bruselas = board.addStation(Station(name: "Bruxeles"))
        let essen = board.addStation(Station(name: "Essen"))
        let copenhagen = board.addStation(Station(name: "Kobenhavn"))
        let stockholm = board.addStation(Station(name: "Stockholm"))
        let petrograd = board.addStation(Station(name: "Petrograd"))
        let riga = board.addStation(Station(name: "Riga"))
        let moskova = board.addStation(Station(name: "Moskova"))
        let berlin = board.addStation(Station(name: "Berlin"))
        let frankfurt = board.addStation(Station(name: "Frankfurt"))
        let munchen = board.addStation(Station(name: "Munchen"))
        var lines:[Line] = []
        
        lines.append(Line(start: cadiz, end: madrid, cost: LineCost.build(type: .red, number: 3)))
        lines.append(Line(start: cadiz, end: lisboa, cost: LineCost.build(type: .blue, number: 2), isTunnel: false))
        lines.append(Line(start: madrid, end: lisboa, cost: LineCost.build(type: .black, number: 3)))
        lines.append(Line(start: madrid, end: barcelona, cost: LineCost.build(type: .orange, number: 2)))
        
        lines.append(Line(start: pamplona, end: paris, cost: LineCost.build(type: .orange, number: 3)))
        
        lines.append(Line(start: madrid, end: pamplona, cost: LineCost.build(type: .black, number: 3)))
        lines.append(Line(start: pamplona, end: brest, cost: LineCost.build(type: .blue, number: 4)))
        lines.append(Line(start: brest, end: paris, cost: LineCost.build(type: .black, number: 3)))
        lines.append(Line(start: diepe, end: paris, cost: LineCost.build(type: .pink, number: 1)))
        
        lines.append(Line(start: brest, end: diepe, cost: LineCost.build(type: .orange, number: 2)))
        lines.append(Line(start: diepe, end: london, cost: LineCost.build(type: .red, number: 2)))
        lines.append(Line(start: edinburg, end: london, cost: LineCost.build(type: .red, number: 4)))
        lines.append(Line(start: amsterdam, end: london, cost: LineCost.build(type: .jocker, number: 2)))
        lines.append(Line(start: amsterdam, end: essen, cost: LineCost.build(type: .yellow, number: 3)))
        
        lines.append(Line(start: essen, end: copenhagen, cost: LineCost.build(type: .jocker, number: 1) + LineCost.build(anyWithNumberOfCards: 2)))
        
        lines.append(Line(start: copenhagen, end: stockholm, cost: LineCost.build(type: .yellow, number: 3)))
        
        lines.append(Line(start: stockholm, end: petrograd, cost: LineCost.build(anyWithNumberOfCards: 8)))
        
        lines.append(Line(start: moskova, end: petrograd, cost: LineCost.build(type: .white, number: 4)))
        
        lines.forEach({ board.addLine($0)})
        
        let route1 = Route(start: cadiz, end: edinburg, points: 8)
        let route2 = Route(start: cadiz, end: paris, points: 5)
        let route3 = Route(start: paris, end: edinburg, points: 4)
        let route4 = Route(start: barcelona, end: essen, points: 10)
        
        return (board, lines, board.stations, [route1, route2, route3, route4])
    }
    
    static func buildDeck() -> Deck{
        let allCards = zip(CardType.allCases, Array(repeating: 12, count: CardType.allCases.count))
        let rules: [CardType: Int]
        
        rules = allCards.reduce([:]) { (dict, rule) -> [CardType: Int] in
            var newDict = dict
            newDict[rule.0] = rule.1
            return newDict
        }
        return Deck(rules: rules)
    }
}
