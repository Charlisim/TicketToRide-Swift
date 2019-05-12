//
//  Game.swift
//  TicketToRideRules
//
//  Created by Carlos Simon on 07/05/2019.
//  Copyright © 2019 AltApps. All rights reserved.
//

import Foundation


public struct Game{
    
    public enum Errors: Error{
        case noEnoughPlayers
        case tooMuchPlayers
        case noRoutes
        case emptyDeck
    }
    
    private static let playerRange = 2...6
    private static let initialCardsForPlayer = 3
    
    public var deck: Deck
    public var market: Deck
    public var discardDeck: Deck
    public var routes: [Route]
    public var board: Board
    public var lineStatus: Set<LineStatus>
    public var players:[Player]
    
    public init(players:[Player], routes: [Route], deck: Deck, board: Board){
        self.players = players
        self.deck = deck
        self.market = Deck(rules: [:])
        self.routes = routes
        self.discardDeck = Deck(rules: [:])
        self.lineStatus = Set()
        self.board = board
        lineStatus.reserveCapacity(routes.count)
        self.board.lines.map({ LineStatus(line: $0) }).forEach({ lineStatus.insert($0) })
    }
    public mutating func initialDeal() throws{
        try self.verifyPlayers()
        try self.verifyDeck()
        try self.verifyRoutes()
        self.deck.shuffle()
        self.dealToPlayers()
        self.dealToMarket()       
    }
    
    private func verifyPlayers() throws{
        if self.players.count < Game.playerRange.lowerBound{
            throw Game.Errors.noEnoughPlayers
        }else if self.players.count > Game.playerRange.upperBound{
            throw Game.Errors.tooMuchPlayers
        }
    }
    private func verifyRoutes() throws{
        if self.routes.isEmpty{
            throw Game.Errors.noRoutes
        }
    }
    
    private func verifyDeck() throws{
        if self.deck.remainingNumberCards == 0{
            throw Game.Errors.emptyDeck
        }
    }
    private mutating func dealToPlayers(){
        (0..<Game.initialCardsForPlayer).forEach { (_) in
            self.players = players.map { (player) -> Player in
                var newPlayer = player
                if let card = self.deck.pop(){
                    newPlayer.hand.add(card: card)
                }
                return newPlayer
                
            }
        }
    }
    private mutating func dealToMarket(){
        self.market.cards = (0..<5).compactMap{ (_) -> Card? in
            return self.deck.pop()
        }
    }
}
