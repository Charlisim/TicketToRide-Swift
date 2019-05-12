//
//  main.swift
//  Exampel
//
//  Created by Carlos Simon on 05/05/2019.
//  Copyright © 2019 AltApps. All rights reserved.
//

import Foundation
import TicketToRideRules




let allCards = zip(CardType.allCases, Array(repeating: 12, count: CardType.allCases.count))
let rules: [CardType: Int]

rules = allCards.reduce([:]) { (dict, rule) -> [CardType: Int] in
    var newDict = dict
    newDict[rule.0] = rule.1
    return newDict
}
var deck = Deck(rules: rules)
var handPlayer1 = Hand(cards: [])
var handPlayer2 = Hand(cards: [])
var market = Market(cards: [])

deck.shuffle()

print(deck)
print(deck.remainingNumberCards)

(0...4).forEach { (index) in
    if let card = deck.pop(){
        handPlayer1.add(card: card)
    }
    if let card2 = deck.pop(){
        handPlayer2.add(card: card2)
    }
}
repeat{
    if let card = deck.pop(){
        market.add(card: card)
    }
} while !market.hasReachLimit()

let card = deck.pop()


print(deck)
print(deck.remainingNumberCards)

print(market)
print(handPlayer1)
print(handPlayer2)

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



let fakeHand = Hand(cards: [.init(type: .red), .init(type: .blue), .init(type: .jocker)])

//Movement().canBuildLine(route, withCardsInHand: fakeHand)


board.addLine(Line(start: cadiz, end: madrid, cost: LineCost.build(type: .red, number: 3)))
board.addLine(Line(start: cadiz, end: lisboa, cost: LineCost.build(type: .blue, number: 2), isTunnel: false))
board.addLine(Line(start: madrid, end: lisboa, cost: LineCost.build(type: .black, number: 3)))
board.addLine(Line(start: madrid, end: barcelona, cost: LineCost.build(type: .orange, number: 2)))

board.addLine(Line(start: pamplona, end: paris, cost: LineCost.build(type: .orange, number: 3)))

board.addLine(Line(start: madrid, end: pamplona, cost: LineCost.build(type: .black, number: 3)))
board.addLine(Line(start: pamplona, end: brest, cost: LineCost.build(type: .blue, number: 4)))
board.addLine(Line(start: brest, end: paris, cost: LineCost.build(type: .black, number: 3)))
board.addLine(Line(start: diepe, end: paris, cost: LineCost.build(type: .pink, number: 1)))

board.addLine(Line(start: brest, end: diepe, cost: LineCost.build(type: .orange, number: 2)))
board.addLine(Line(start: diepe, end: london, cost: LineCost.build(type: .red, number: 2)))
board.addLine(Line(start: edinburg, end: london, cost: LineCost.build(type: .red, number: 4)))
board.addLine(Line(start: amsterdam, end: london, cost: LineCost.build(type: .jocker, number: 2)))
board.addLine(Line(start: amsterdam, end: essen, cost: LineCost.build(type: .yellow, number: 3)))

board.addLine(Line(start: essen, end: copenhagen, cost: LineCost.build(type: .jocker, number: 1) + LineCost.build(anyWithNumberOfCards: 2)))

board.addLine(Line(start: copenhagen, end: stockholm, cost: LineCost.build(type: .yellow, number: 3)))

board.addLine(Line(start: stockholm, end: petrograd, cost: LineCost.build(anyWithNumberOfCards: 8)))

board.addLine(Line(start: moskova, end: petrograd, cost: LineCost.build(type: .white, number: 4)))

print(board)

print(Dijkstra.getShortestPath(from: cadiz, to: edinburg, graph: board.graph))
print(Dijkstra.getEdges(alongPathsFrom: madrid, graph: board.graph))

let route1 = Route(start: cadiz, end: edinburg, points: 8)
let route2 = Route(start: cadiz, end: paris, points: 5)
let route3 = Route(start: paris, end: edinburg, points: 4)
let route4 = Route(start: barcelona, end: essen, points: 10)


let shortestPath = Set(Dijkstra.getShortestPath(from: cadiz, to: edinburg, graph: board.graph))
let shortesPathParisEdinburg = Set(Dijkstra.getShortestPath(from: paris, to: edinburg, graph: board.graph))

print(shortestPath)
print(shortesPathParisEdinburg)

print("UNION: \(shortesPathParisEdinburg.union(shortestPath))")
print("INTERSECCION \(shortesPathParisEdinburg.intersection(shortestPath))")


// Calcular ruta optima entre varias rutas.
// Se calcula el camino mas rapido la ruta 1, si pasa por alguna estación que es el inicio, estacion intermedia o final. Si es la estación inicial se calculará la subruta entre la estación inicial y la estación coincidente.

let shortestPathCadizEdinburg = Set(Dijkstra.getShortestPath(from: cadiz, to: edinburg, graph: board.graph))
let shortesPathParisEdinburg2 = Set(Dijkstra.getShortestPath(from: paris, to: edinburg, graph: board.graph))

let subrute = shortestPathCadizEdinburg.subtracting(shortesPathParisEdinburg2)

print(subrute)

let barcelonaEssen = Set(Dijkstra.getShortestPath(from: route4.start, to: route4.end, graph: board.graph))

print(barcelonaEssen)
var subroute2:Set<Line> = barcelonaEssen
for routePath in [shortesPathParisEdinburg2, shortestPathCadizEdinburg]{
    subroute2 = subroute2.subtracting(routePath)
}

print(subroute2)


for line in subroute2{
    let build = Movement().calculateBuild(line, withCardsInHand: handPlayer1, market: market)
    print("BUILD STATUS: \(build) - START: \(line.start) - END: \(line.end)")
}
let player = Player(name: "Player-1")

let game = Game(players:[player] , routes: [route1, route2, route3, route4], deck: deck)

print(player)

print(game)
