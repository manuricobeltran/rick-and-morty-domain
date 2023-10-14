//
//  EpisodeEndpointsTests.swift
//
//
//  Created by Manu Rico on 12/10/23.
//

import XCTest
import Combine
import Factory
@testable import RickAndMortyDomain


class EpisodeEndpointsTests: XCTestCase {
    
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
    
    func testGetEpisodeEmptyStatusCode200() throws {
        try checkNetworkConnection()
        
        // given
        let request = API.Episode.getEpisodes([1]).urlRequest!
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
    
    func testGetSelectedEpisodesEmptyStatusCode200() throws {
        try checkNetworkConnection()
        
        // given
        let request = API.Episode.getEpisodes([]).urlRequest!
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
    
    func testGetSelectedEpisodesStatusCode200() throws {
        try checkNetworkConnection()
        
        // given
        let request = API.Episode.getEpisodes([1, 2, 3]).urlRequest!
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
    
    func testGetEpisodesDefaultPageStatusCode200() throws {
        try checkNetworkConnection()
        
        // given
        let request = API.Episode.getAllEpisodes(nil).urlRequest!
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
    
    func testGetEpisodesPageStatusCode200() throws {
        try checkNetworkConnection()
        
        // given
        let request = API.Episode.getAllEpisodes(1).urlRequest!
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
    
    func testGetInvalidEpisode() throws {
        try checkNetworkConnection()
        
        // given
        let request = API.Episode.getEpisodes([-200]).urlRequest!
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
