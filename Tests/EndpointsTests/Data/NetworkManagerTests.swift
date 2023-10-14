//
//  NetworkManagerTests.swift
//
//
//  Created by Manu Rico on 14/10/23.
//

import XCTest
import Combine
import Factory
@testable import RickAndMortyDomain

class NetworkManagerTests: XCTestCase {
    
    private let network = NetworkManager(withSession: .mocked)
    private let networkTimeout: CGFloat = 1.0
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testRequestCode200() async throws {
        
        // given
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url else {
                return (nil, nil, nil)
            }
            return (
                HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil),
                "".data(using: .utf8),
                nil
            )
        }
        
        let request = API.Location.getLocations([1]).urlRequest!
        let promise = expectation(description: "Status code: 200")
        
        // when
        do {
            _ = try await network.run(request)
            promise.fulfill()
        } catch let error as DataError {
            XCTFail("Error: \(error.rawValue)")
        }
        
        // then
        await fulfillment(of: [promise], timeout: networkTimeout)
    }
}
