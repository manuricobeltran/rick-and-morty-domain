//
//  CharacterEndpointsTests.swift
//
//
//  Created by Manu Rico on 12/10/23.
//

import XCTest
import Combine
import Factory
@testable import RickAndMortyDomain


class CharacterEndpointsTests: XCTestCase {
    
    private let network = Container.shared.networkManager()
    private let networkMonitor = NetworkMonitor.shared
    private let networkTimeout: CGFloat = 3.0
    
    private func checkNetworkConnection() throws {
        try XCTSkipUnless(networkMonitor.isReachable, "Network connectivity needed for this test.")
    }
    
    var subscriptions = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testGetCharacterEmptyStatusCode200() throws {
        try checkNetworkConnection()
        
        // given
        let request = API.Character.getCharacters([1]).urlRequest!
        let promise = expectation(description: "Status code: 200")
        
        // when
        network.run(request)
            .sink { completion in
                if case let .failure(error) = completion {
                    XCTFail("Error: \(error.rawValue)")
                }
            } receiveValue: { _ in
                promise.fulfill()
            }.store(in: &subscriptions)
        
        // then
        wait(for: [promise], timeout: networkTimeout)
    }
    
    func testGetSelectedCharactersEmptyStatusCode200() throws {
        try checkNetworkConnection()
        
        // given
        let request = API.Character.getCharacters([]).urlRequest!
        let promise = expectation(description: "Status code: 200")
        
        // when
        network.run(request)
            .sink { completion in
                if case let .failure(error) = completion {
                    XCTFail("Error: \(error.rawValue)")
                }
            } receiveValue: { _ in
                promise.fulfill()
            }.store(in: &subscriptions)
        
        // then
        wait(for: [promise], timeout: networkTimeout)
    }
    
    func testGetSelectedCharactersStatusCode200() throws {
        try checkNetworkConnection()
        
        // given
        let request = API.Character.getCharacters([1, 2, 3]).urlRequest!
        let promise = expectation(description: "Status code: 200")
        
        // when
        network.run(request)
            .sink { completion in
                if case let .failure(error) = completion {
                    XCTFail("Error: \(error.rawValue)")
                }
            } receiveValue: { _ in
                promise.fulfill()
            }.store(in: &subscriptions)
        
        // then
        wait(for: [promise], timeout: networkTimeout)
    }
    
    func testGetCharactersDefaultPageStatusCode200() throws {
        try checkNetworkConnection()
        
        // given
        let request = API.Character.getAllCharacters(nil).urlRequest!
        let promise = expectation(description: "Status code: 200")
        
        // when
        network.run(request)
            .sink { completion in
                if case let .failure(error) = completion {
                    XCTFail("Error: \(error.rawValue)")
                }
            } receiveValue: { _ in
                promise.fulfill()
            }.store(in: &subscriptions)
        
        // then
        wait(for: [promise], timeout: networkTimeout)
    }
    
    func testGetCharactersPageStatusCode200() throws {
        try checkNetworkConnection()
        
        // given
        let request = API.Character.getAllCharacters(1).urlRequest!
        let promise = expectation(description: "Status code: 200")
        
        // when
        network.run(request)
            .sink { completion in
                if case let .failure(error) = completion {
                    XCTFail("Error: \(error.rawValue)")
                }
            } receiveValue: { _ in
                promise.fulfill()
            }.store(in: &subscriptions)
        
        // then
        wait(for: [promise], timeout: networkTimeout)
    }
    
    func testGetInvalidCharacter() throws {
        try checkNetworkConnection()
        
        // given
        let request = API.Character.getCharacters([-200]).urlRequest!
        let promise = expectation(description: "Status code: 404")
        
        // when
        network.run(request)
            .sink { completion in
                if case .failure = completion {
                    promise.fulfill()
                }
            } receiveValue: { _ in
                XCTFail("Error: network call must have failed")
            }.store(in: &subscriptions)
        
        // then
        wait(for: [promise], timeout: networkTimeout)
    }
}
