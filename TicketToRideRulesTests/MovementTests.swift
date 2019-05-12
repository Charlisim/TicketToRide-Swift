//
//  MovementTests.swift
//  TicketToRideRulesTests
//
//  Created by Carlos Simon on 05/05/2019.
//  Copyright © 2019 AltApps. All rights reserved.
//

import XCTest
@testable import TicketToRideRules

class MovementTests: XCTestCase {


    func testCanBuildWithHandExactResult() {
        let cadiz = Station(name: "Cadiz")
        let madrid = Station(name: "Madrid")
        let route = Line(start: cadiz, end: madrid, cost: LineCost.build(type: .red, number: 3))
        let fakeHand = Hand(cardTypes: [.red, .blue, .red, .green, .red])
        let fakeMarket = Market(cardTypes: [.jocker, .black, .blue, .orange, .pink])
        
        let sut = Movement()
        
        let result = sut.calculateBuild(route, withCardsInHand: fakeHand, market: fakeMarket)
        XCTAssertEqual(result, Movement.Result.canBuildWithHand)
        
    }
    func testCanBuildWithHandExactResultUsingJocker() {
        let cadiz = Station(name: "Cadiz")
        let madrid = Station(name: "Madrid")
        let route = Line(start: cadiz, end: madrid, cost: LineCost.build(type: .red, number: 3))
        let fakeHand = Hand(cardTypes: [.red, .red, .jocker, .green, .blue])
        let fakeMarket = Market(cardTypes: [.jocker, .red, .blue, .red])
        let sut = Movement()

        let result = sut.calculateBuild(route, withCardsInHand: fakeHand, market: fakeMarket)
        XCTAssertEqual(result, Movement.Result.canBuildWithHand)
        
    }
    func testCanBuildWithHandExceeds() {
        let cadiz = Station(name: "Cadiz")
        let madrid = Station(name: "Madrid")
        let route = Line(start: cadiz, end: madrid, cost: LineCost.build(type: .red, number: 3))
        let fakeHand = Hand(cardTypes: [.red, .red, .jocker, .green, .blue, .red, .red])
        let fakeMarket = Market(cardTypes: [.jocker, .red, .blue, .red])
        let sut = Movement()
        
        let result = sut.calculateBuild(route, withCardsInHand: fakeHand, market: fakeMarket)
        XCTAssertEqual(result, Movement.Result.canBuildWithHand)
    }
    
    func testCanAnyColorLineWithHand() {
        let cadiz = Station(name: "Cadiz")
        let madrid = Station(name: "Madrid")
        let route = Line(start: cadiz, end: madrid, cost: LineCost.build(anyWithNumberOfCards: 3))
        let fakeHand = Hand(cardTypes: [.green, .green, .jocker, .green, .blue, .red, .red])
        let fakeMarket = Market(cardTypes: [.jocker, .red, .blue, .red])
        let sut = Movement()
        
        let result = sut.calculateBuild(route, withCardsInHand: fakeHand, market: fakeMarket)
        XCTAssertEqual(result, Movement.Result.canBuildWithHand)
    }
    func testCanAnyColorLinePlusJockerWithHand() {
        let cadiz = Station(name: "Cadiz")
        let madrid = Station(name: "Madrid")
        let route = Line(start: cadiz, end: madrid, cost: LineCost.build(anyWithNumberOfCards: 3) + [LineCost(cardType: .jocker)])
        let fakeHand = Hand(cardTypes: [.green, .green, .jocker, .green, .blue, .red, .red])
        let fakeMarket = Market(cardTypes: [.jocker, .red, .blue, .red])
        let sut = Movement()
        
        let result = sut.calculateBuild(route, withCardsInHand: fakeHand, market: fakeMarket)
        XCTAssertEqual(result, Movement.Result.canBuildWithHand)
    }
    func testCantBuildAnyColorLinePlusJockerWithHand() {
        let cadiz = Station(name: "Cadiz")
        let madrid = Station(name: "Madrid")
        let route = Line(start: cadiz, end: madrid, cost: LineCost.build(anyWithNumberOfCards: 3) + [LineCost(cardType: .jocker)])
        let fakeHand = Hand(cardTypes: [.green, .green, .green, .green, .blue, .red, .red])
        let fakeMarket = Market(cardTypes: [.pink, .black, .blue, .black])
        let sut = Movement()
        
        let result = sut.calculateBuild(route, withCardsInHand: fakeHand, market: fakeMarket)
        XCTAssertEqual(result, .none)
    }
    func testCanBuildTakingMarketAllColorLine() {
        let cadiz = Station(name: "Cadiz")
        let madrid = Station(name: "Madrid")
        let route = Line(start: cadiz, end: madrid, cost: LineCost.build(type: .red, number: 3))
        let fakeHand = Hand(cardTypes: [.green, .green, .green, .green, .blue, .red, .red])
        let fakeMarket = Market(cardTypes: [.pink, .red, .blue, .black])
        let sut = Movement()
        
        let result = sut.calculateBuild(route, withCardsInHand: fakeHand, market: fakeMarket)
        XCTAssertEqual(result, .canBuildTakingMarket)
    }
    func testCantBuildTakingMarketAllColorLine() {
        let cadiz = Station(name: "Cadiz")
        let madrid = Station(name: "Madrid")
        let route = Line(start: cadiz, end: madrid, cost: LineCost.build(type: .red, number: 3))
        let fakeHand = Hand(cardTypes: [.green, .green, .green, .green, .blue, .red, .red])
        let fakeMarket = Market(cardTypes: [.pink, .green, .blue, .black])
        let sut = Movement()
        
        let result = sut.calculateBuild(route, withCardsInHand: fakeHand, market: fakeMarket)
        XCTAssertEqual(result, .none)
    }
    func testCanBuildTakingMarketAllColorLineUsingJocker() {
        let cadiz = Station(name: "Cadiz")
        let madrid = Station(name: "Madrid")
        let route = Line(start: cadiz, end: madrid, cost: LineCost.build(type: .red, number: 3))
        let fakeHand = Hand(cardTypes: [.green, .green, .green, .green, .blue, .red, .red])
        let fakeMarket = Market(cardTypes: [.pink, .jocker, .blue, .black])
        let sut = Movement()
        
        let result = sut.calculateBuild(route, withCardsInHand: fakeHand, market: fakeMarket)
        XCTAssertEqual(result, .canBuildTakingMarket)
    }
    func testCanBuildAnyColorLinePlusJockerWithMarket() {
        let cadiz = Station(name: "Cadiz")
        let madrid = Station(name: "Madrid")
        let route = Line(start: cadiz, end: madrid, cost: LineCost.build(anyWithNumberOfCards: 3) + [LineCost(cardType: .jocker)])
        let fakeHand = Hand(cardTypes: [.green, .green, .green, .red, .blue, .red, .red])
        let fakeMarket = Market(cardTypes: [.pink, .jocker, .blue, .black])
        let sut = Movement()
        
        let result = sut.calculateBuild(route, withCardsInHand: fakeHand, market: fakeMarket)
        XCTAssertEqual(result, .canBuildTakingMarket)
    }
    func testCanBuildAnyColorLineWithMarketMissingColor() {
        let cadiz = Station(name: "Cadiz")
        let madrid = Station(name: "Madrid")
        let route = Line(start: cadiz, end: madrid, cost: LineCost.build(anyWithNumberOfCards: 3))
        let fakeHand = Hand(cardTypes: [.green, .green, .black, .jocker, .blue, .red, .red])
        let fakeMarket = Market(cardTypes: [.pink, .red, .green, .black])
        let sut = Movement()
        
        let result = sut.calculateBuild(route, withCardsInHand: fakeHand, market: fakeMarket)
        XCTAssertEqual(result, .canBuildTakingMarket)
    }
    func testCantBuildAnyColorLinePlusJockerWithMarket() {
        let cadiz = Station(name: "Cadiz")
        let madrid = Station(name: "Madrid")
        let route = Line(start: cadiz, end: madrid, cost: LineCost.build(anyWithNumberOfCards: 3) + [LineCost(cardType: .jocker)])
        let fakeHand = Hand(cardTypes: [.green, .green, .green, .red, .blue, .red, .red])
        let fakeMarket = Market(cardTypes: [.pink, .blue, .blue, .black, .orange])
        let sut = Movement()
        
        let result = sut.calculateBuild(route, withCardsInHand: fakeHand, market: fakeMarket)
        XCTAssertEqual(result, .none)
    }
    func testCanBuildTakingMarketTakingBlue() {
        let cadiz = Station(name: "Cadiz")
        let madrid = Station(name: "Madrid")
        let route = Line(start: cadiz, end: madrid, cost: LineCost.build(anyWithNumberOfCards: 3) + [LineCost(cardType: .jocker)])
        let fakeHand = Hand(cardTypes: [.green, .green, .jocker, .blue, .red, .red])
        let fakeMarket = Market(cardTypes: [.pink, .blue, .blue, .black])
        let sut = Movement()
        
        let result = sut.calculateBuild(route, withCardsInHand: fakeHand, market: fakeMarket)
        XCTAssertEqual(result, .canBuildTakingMarket)
    }
    
    func testTakingMarketHelps(){
        let cadiz = Station(name: "Cadiz")
        let madrid = Station(name: "Madrid")
        let route = Line(start: cadiz, end: madrid, cost: LineCost.build(anyWithNumberOfCards: 3))
        let fakeHand = Hand(cardTypes: [.green, .green, .black, .blue, .red, .red])
        let fakeMarket = Market(cardTypes: [.pink, .blue, .white, .black])
        let sut = Movement()
        
        let result = sut.calculateBuild(route, withCardsInHand: fakeHand, market: fakeMarket)
        XCTAssertEqual(result, .takingMarketHelps)
    }
    func testTakingMarketHelpsColoredLine(){
        let cadiz = Station(name: "Cadiz")
        let madrid = Station(name: "Madrid")
        let route = Line(start: cadiz, end: madrid, cost: LineCost.build(type: .red, number: 4))
        let fakeHand = Hand(cardTypes: [.green, .green, .black, .blue, .red, .red])
        let fakeMarket = Market(cardTypes: [.pink, .blue, .white, .black, .red])
        let sut = Movement()
        
        let result = sut.calculateBuild(route, withCardsInHand: fakeHand, market: fakeMarket)
        XCTAssertEqual(result, .takingMarketHelps)
    }
    func testTakingMarketHelpsAnyColorLine(){
        let cadiz = Station(name: "Cadiz")
        let madrid = Station(name: "Madrid")
        let route = Line(start: cadiz, end: madrid, cost: LineCost.build(anyWithNumberOfCards: 3))
        let fakeHand = Hand(cardTypes: [.green, .green, .black, .red, .red])
        let fakeMarket = Market(cardTypes: [.pink, .blue, .white])
        let sut = Movement()
        
        let result = sut.calculateBuild(route, withCardsInHand: fakeHand, market: fakeMarket)
        XCTAssertEqual(result, .takingMarketHelps)
    }
    func testNothingHelpsColoredLine(){
        let cadiz = Station(name: "Cadiz")
        let madrid = Station(name: "Madrid")
        let route = Line(start: cadiz, end: madrid, cost: LineCost.build(type: .red, number: 4))
        let fakeHand = Hand(cardTypes: [.green, .red, .red])
        let fakeMarket = Market(cardTypes: [.pink, .blue, .white, .black, .orange])
        let sut = Movement()
        
        let result = sut.calculateBuild(route, withCardsInHand: fakeHand, market: fakeMarket)
        XCTAssertEqual(result, .none)
    
    }


}
