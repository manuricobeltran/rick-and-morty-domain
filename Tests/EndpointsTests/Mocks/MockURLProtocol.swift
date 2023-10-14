//
//  MockURLProtocol.swift
//
//
//  Created by Manu Rico on 14/10/23.
//

import Foundation
import Network
import XCTest

extension URLSession {
    
    static var mocked: URLSession {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: configuration)
    }
}


class MockURLProtocol: URLProtocol {
    
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse?, Data?, Error?))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        mockResponse()
    }
    
    override func stopLoading() {
        mockResponse()
    }
}

private extension MockURLProtocol {
    
    func mockResponse() {
        guard let handler = MockURLProtocol.requestHandler else {
            XCTFail("No request handler provided")
            return
        }
        
        do {
            let (response, data, error) = try handler(request)
            if let response {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            if let data {
                client?.urlProtocol(self, didLoad: data)
                client?.urlProtocolDidFinishLoading(self)
            }
            if let error {
                client?.urlProtocol(self, didFailWithError: error)
            }
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
}
