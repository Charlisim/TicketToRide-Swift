//
//  GameTests.swift
//  TicketToRideRulesTests
//
//  Created by Carlos Simon on 09/05/2019.
//  Copyright © 2019 AltApps. All rights reserved.
//

import XCTest
@testable import TicketToRideRules

class GameDealTests: XCTestCase {

    
    func testInitInitializeLineStatus(){
        let (board, lines, stations, routes) = MockData.buildBoard()
        let players = [Player(name: "Player-1"), Player(name: "Player-2")]
        let deck = MockData.buildDeck()
        var game = Game(players: players, routes: routes, deck: deck, board: board)
        XCTAssertEqual(game.lineStatus.count, lines.count)
    }
    func testInitialDealShouldRaiseErrorIfNoPlayers(){
        let (board, _, _, routes) = MockData.buildBoard()
        let deck = MockData.buildDeck()
        var game = Game(players: [], routes: routes, deck: deck, board: board)
        XCTAssertThrowsError(try game.initialDeal(), "No players") { (error) in
            XCTAssertEqual(Game.Errors.noEnoughPlayers, error as! Game.Errors)
        }
    }
    func testsInitialDealShouldRaiseErrorIfNoDeck(){
        let (board, _, _, routes) = MockData.buildBoard()
        let players = [Player(name: "Player-1"), Player(name: "Player-2")]
        var game = Game(players: players, routes: routes, deck: Deck(rules: [:]), board: board)
        XCTAssertThrowsError(try game.initialDeal(), "No deck") { (error) in
            XCTAssertEqual(Game.Errors.emptyDeck, error as! Game.Errors)
        }
    }
    func testInitialDealShouldRaiseErrorIfNoEnoughPlayers(){
        let (board, _, _, routes) = MockData.buildBoard()
        let players = [Player(name: "Player-1")]
        let deck = MockData.buildDeck()
        var game = Game(players: players, routes: routes, deck: deck, board: board)
        XCTAssertThrowsError(try game.initialDeal(), "No enough players") { (error) in
            XCTAssertEqual(Game.Errors.noEnoughPlayers, error as! Game.Errors)
        }
    }
    func testInitialDealShouldRaiseErrorIfTooMuchPlayers(){
        let (board, _, _, routes) = MockData.buildBoard()
        let players = Array(repeating: Player(name: "Player-1"), count: 7)
        let deck = MockData.buildDeck()
        var game = Game(players: players, routes: routes, deck: deck, board: board)
        XCTAssertThrowsError(try game.initialDeal(), "Too much players") { (error) in
            XCTAssertEqual(Game.Errors.tooMuchPlayers, error as! Game.Errors)
        }
    }

    func testInitialDealShouldRaiseErrorIfNoRoutes(){
        let (board, _, _, routes) = MockData.buildBoard()
        let players = [Player(name: "Player-1"), Player(name: "Player-2")]
        let deck = MockData.buildDeck()
        var game = Game(players: players, routes: [], deck: deck, board: board)
        XCTAssertThrowsError(try game.initialDeal(), "No routes") { (error) in
            XCTAssertEqual(Game.Errors.noRoutes, error as! Game.Errors)
        }
    }
    
    func testInitialEachPlayerShouldHave3Cards(){
        let (board, _, _, routes) = MockData.buildBoard()
        let players = [Player(name: "Player-1"), Player(name: "Player-2")]
        let deck = MockData.buildDeck()
        var game = Game(players: players, routes: routes, deck: deck, board: board)
        XCTAssertNoThrow(try game.initialDeal())
        XCTAssertEqual(game.players.first!.hand.cards.count, 3)
        XCTAssertEqual(game.players[1].hand.cards.count, 3)

    }
    func testInitialShouldHave5CardsInMarket(){
        let (board, _, _, routes) = MockData.buildBoard()
        let players = [Player(name: "Player-1"), Player(name: "Player-2")]
        let deck = MockData.buildDeck()
        var game = Game(players: players, routes: routes, deck: deck, board: board)
        XCTAssertNoThrow(try game.initialDeal())
        XCTAssertEqual(game.market.cards.count, 5)
    }
    
    func testInitialShouldHaveReducedTheNumberOfCardsInDeck(){
        let (board, _, _, routes) = MockData.buildBoard()
        let players = [Player(name: "Player-1"), Player(name: "Player-2")]
        let deck = MockData.buildDeck()
        let initialNumberCards = deck.remainingNumberCards
        var game = Game(players: players, routes: routes, deck: deck, board: board)
        XCTAssertNoThrow(try game.initialDeal())
        XCTAssertEqual(game.deck.remainingNumberCards, initialNumberCards - (players.count * 3) - 5)
    }
    
    func testPlayersHave45Trains(){
        let (board, _, _, routes) = MockData.buildBoard()
        let players = [Player(name: "Player-1"), Player(name: "Player-2")]
        let deck = MockData.buildDeck()
        var game = Game(players: players, routes: routes, deck: deck, board: board)
        XCTAssertNoThrow(try game.initialDeal())
        XCTAssertEqual(game.players.first!.trains, 45)
        XCTAssertEqual(game.players[1].trains, 45)
    }
}
