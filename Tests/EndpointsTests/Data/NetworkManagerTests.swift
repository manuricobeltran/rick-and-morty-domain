//
//  NetworkManagerTests.swift
//
//
//  Created by Manu Rico on 14/10/23.
//

import XCTest
import Combine
@testable import RickAndMortyDomain

class NetworkManagerTests: XCTestCase {
    
    private var sut: NetworkManager!
    private let networkTimeout: CGFloat = 1.0
    private var subscription: AnyCancellable?
    
    override func setUp() {
        sut = NetworkManager(withSession: .mocked)
        subscription = nil
    }
    
    override func tearDown() {
        sut = nil
        subscription = nil
    }
}
    
// MARK: - Async Network requests

extension NetworkManagerTests {
 
    func testEmptyResponseStatusCode200() async throws {
        
        // given
        MockURLProtocol.requestHandler = { request in
            return (
                MockResponse.mockResponse(withURL: request.url!, statusCode: 200),
                MockResponse.mockResponseEmptyData,
                nil
            )
        }
        
        let request = API.Mock.getRequest.urlRequest!
        let promise = expectation(description: "Status code: 200")
        
        // when
        do {
            _ = try await sut.run(request)
            promise.fulfill()
        }
        
        // then
        await fulfillment(of: [promise], timeout: networkTimeout)
    }
    
    func testEmptyResponseError() async throws {
        
        // given
        MockURLProtocol.requestHandler = { request in
            return (
                MockResponse.mockResponse(withURL: request.url!, statusCode: 999),
                MockResponse.mockResponseEmptyData,
                nil
            )
        }
        
        let request = API.Mock.getRequest.urlRequest!
        let promise = expectation(description: "Status code: unknown")
        
        // when
        do {
            _ = try await sut.run(request)
        } catch let error as DataError {
            if error == .unknown {
                promise.fulfill()
            }
        }
        
        // then
        await fulfillment(of: [promise], timeout: networkTimeout)
    }
    
    func testDecodedResponseStatusCode200() async throws {
        
        // given
        MockURLProtocol.requestHandler = { request in
            return (
                MockResponse.mockResponse(withURL: request.url!, statusCode: 200),
                MockResponse.mockResponseDemoData,
                nil
            )
        }
        
        let request = API.Mock.getRequest.urlRequest!
        let promise = expectation(description: "Status code: 200 with decoded data")
        
        // when
        do {
            let data: MockEntity = try await sut.run(request)
            if data.string == MockResponse.mockDecodedString && data.integer == MockResponse.mockDecodedInt {
                promise.fulfill()
            }
        }
        
        // then
        await fulfillment(of: [promise], timeout: networkTimeout)
    }
    
    func testDecodedResponseError() async throws {
        
        // given
        MockURLProtocol.requestHandler = { request in
            return (
                MockResponse.mockResponse(withURL: request.url!, statusCode: 999),
                MockResponse.mockResponseDemoData,
                nil
            )
        }
        
        let request = API.Mock.getRequest.urlRequest!
        let promise = expectation(description: "Status code: unknown")
        
        // when
        do {
            let _: MockEntity = try await sut.run(request)
            XCTFail("Error: Request must fail")
        } catch let error as DataError {
            if error == .unknown {
                promise.fulfill()
            }
        }
        
        // then
        await fulfillment(of: [promise], timeout: networkTimeout)
    }
    
    func testResponseDecodingError() async throws {
        
        // given
        MockURLProtocol.requestHandler = { request in
            return (
                MockResponse.mockResponse(withURL: request.url!, statusCode: 200),
                MockResponse.mockResponseDemoData,
                nil
            )
        }
        
        let request = API.Mock.getRequest.urlRequest!
        let promise = expectation(description: "Decoding Error")
        
        // when
        do {
            let _: String = try await sut.run(request)
            XCTFail("Error: Request must fail")
        } catch let error as DataError {
            if error == .decoding {
                promise.fulfill()
            } else {
                XCTFail("Error: Request must fail with decoding error")
            }
        }
        
        // then
        await fulfillment(of: [promise], timeout: networkTimeout)
    }
    
    func testResponseStatusCode400() async throws {
        
        // given
        MockURLProtocol.requestHandler = { request in
            return (
                MockResponse.mockResponse(withURL: request.url!, statusCode: 400),
                MockResponse.mockResponseEmptyData,
                nil
            )
        }
        
        let request = API.Mock.getRequest.urlRequest!
        let promise = expectation(description: "Status code: 400")
        
        // when
        do {
            _ = try await sut.run(request)
        } catch let error as DataError {
            if error == .badRequest {
                promise.fulfill()
            }
        }
        
        // then
        await fulfillment(of: [promise], timeout: networkTimeout)
    }
    
    func testResponseStatusCode401() async throws {
        
        // given
        MockURLProtocol.requestHandler = { request in
            return (
                MockResponse.mockResponse(withURL: request.url!, statusCode: 401),
                MockResponse.mockResponseEmptyData,
                nil
            )
        }
        
        let request = API.Mock.getRequest.urlRequest!
        let promise = expectation(description: "Status code: 401")
        
        // when
        do {
            _ = try await sut.run(request)
        } catch let error as DataError {
            if error == .unauthorized {
                promise.fulfill()
            }
        }
        
        // then
        await fulfillment(of: [promise], timeout: networkTimeout)
    }
    
    func testResponseStatusCode403() async throws {
        
        // given
        MockURLProtocol.requestHandler = { request in
            return (
                MockResponse.mockResponse(withURL: request.url!, statusCode: 403),
                MockResponse.mockResponseEmptyData,
                nil
            )
        }
        
        let request = API.Mock.getRequest.urlRequest!
        let promise = expectation(description: "Status code: 403")
        
        // when
        do {
            _ = try await sut.run(request)
        } catch let error as DataError {
            if error == .forbidden {
                promise.fulfill()
            }
        }
        
        // then
        await fulfillment(of: [promise], timeout: networkTimeout)
    }
    
    func testResponseStatusCode404() async throws {
        
        // given
        MockURLProtocol.requestHandler = { request in
            return (
                MockResponse.mockResponse(withURL: request.url!, statusCode: 404),
                MockResponse.mockResponseEmptyData,
                nil
            )
        }
        
        let request = API.Mock.getRequest.urlRequest!
        let promise = expectation(description: "Status code: 404")
        
        // when
        do {
            _ = try await sut.run(request)
        } catch let error as DataError {
            if error == .notFound {
                promise.fulfill()
            }
        }
        
        // then
        await fulfillment(of: [promise], timeout: networkTimeout)
    }
    
    func testResponseStatusCode409() async throws {
        
        // given
        MockURLProtocol.requestHandler = { request in
            return (
                MockResponse.mockResponse(withURL: request.url!, statusCode: 409),
                MockResponse.mockResponseEmptyData,
                nil
            )
        }
        
        let request = API.Mock.getRequest.urlRequest!
        let promise = expectation(description: "Status code: 409")
        
        // when
        do {
            _ = try await sut.run(request)
        } catch let error as DataError {
            if error == .conflict {
                promise.fulfill()
            }
        }
        
        // then
        await fulfillment(of: [promise], timeout: networkTimeout)
    }
    
    func testResponseStatusCode429() async throws {
        
        // given
        MockURLProtocol.requestHandler = { request in
            return (
                MockResponse.mockResponse(withURL: request.url!, statusCode: 429),
                MockResponse.mockResponseEmptyData,
                nil
            )
        }
        
        let request = API.Mock.getRequest.urlRequest!
        let promise = expectation(description: "Status code: 429")
        
        // when
        do {
            _ = try await sut.run(request)
        } catch let error as DataError {
            if error == .tooManyRequests {
                promise.fulfill()
            }
        }
        
        // then
        await fulfillment(of: [promise], timeout: networkTimeout)
    }
    
    func testResponseStatusCode500() async throws {
        
        // given
        MockURLProtocol.requestHandler = { request in
            return (
                MockResponse.mockResponse(withURL: request.url!, statusCode: 500),
                MockResponse.mockResponseEmptyData,
                nil
            )
        }
        
        let request = API.Mock.getRequest.urlRequest!
        let promise = expectation(description: "Status code: 500")
        
        // when
        do {
            _ = try await sut.run(request)
        } catch let error as DataError {
            if error == .server {
                promise.fulfill()
            }
        }
        
        // then
        await fulfillment(of: [promise], timeout: networkTimeout)
    }
    
    func testResponseStatusCode503() async throws {
        
        // given
        MockURLProtocol.requestHandler = { request in
            return (
                MockResponse.mockResponse(withURL: request.url!, statusCode: 503),
                MockResponse.mockResponseEmptyData,
                nil
            )
        }
        
        let request = API.Mock.getRequest.urlRequest!
        let promise = expectation(description: "Status code: 503")
        
        // when
        do {
            _ = try await sut.run(request)
        } catch let error as DataError {
            if error == .maintenanceMode {
                promise.fulfill()
            }
        }
        
        // then
        await fulfillment(of: [promise], timeout: networkTimeout)
    }
    
    func testResponseStatusCodeUnknown() async throws {
        
        // given
        MockURLProtocol.requestHandler = { request in
            return (
                MockResponse.mockResponse(withURL: request.url!, statusCode: 415),
                MockResponse.mockResponseEmptyData,
                nil
            )
        }
        
        let request = API.Mock.getRequest.urlRequest!
        let promise = expectation(description: "Status code: Unknown")
        
        // when
        do {
            _ = try await sut.run(request)
        } catch let error as DataError {
            if error == .unknown {
                promise.fulfill()
            }
        }
        
        // then
        await fulfillment(of: [promise], timeout: networkTimeout)
    }
}

// MARK: - Combine Network requests

extension NetworkManagerTests {
    
    func testRxEmptyResponseStatusCode200() throws {
        
        // given
        MockURLProtocol.requestHandler = { request in
            return (
                MockResponse.mockResponse(withURL: request.url!, statusCode: 200),
                MockResponse.mockResponseEmptyData,
                nil
            )
        }
        
        let request = API.Mock.getRequest.urlRequest!
        let promise = expectation(description: "Status code: 200")
        
        // when
        subscription = sut.run(request)
            .sink { completion in
                if case .finished = completion {
                    promise.fulfill()
                }
            } receiveValue: { _ in }
        
        // then
        wait(for: [promise], timeout: networkTimeout)
    }
    
    func testRxEmptyResponseError() throws {
        
        // given
        MockURLProtocol.requestHandler = { request in
            return (
                MockResponse.mockResponse(withURL: request.url!, statusCode: 999),
                MockResponse.mockResponseEmptyData,
                nil
            )
        }
        
        let request = API.Mock.getRequest.urlRequest!
        let promise = expectation(description: "Status code: unknown")
        
        // when
        subscription = sut.run(request)
            .sink { completion in
                if case let .failure(error) = completion, error == .unknown {
                    promise.fulfill()
                } else {
                    XCTFail("Error: Request must fail with unknown error")
                }
            } receiveValue: { _ in
                XCTFail("Error: Request must fail")
            }
        
        // then
        wait(for: [promise], timeout: networkTimeout)
    }
    
    func testRxDecodedResponseStatusCode200() throws {
        
        // given
        MockURLProtocol.requestHandler = { request in
            return (
                MockResponse.mockResponse(withURL: request.url!, statusCode: 200),
                MockResponse.mockResponseDemoData,
                nil
            )
        }
        
        let request = API.Mock.getRequest.urlRequest!
        let promise = expectation(description: "Status code: 200 with decoded data")
        
        // when
        subscription = sut.run(request)
            .sink { _ in
                // Intentionally empty
            } receiveValue: { (data: MockEntity) in
                if data.string == MockResponse.mockDecodedString && data.integer == MockResponse.mockDecodedInt {
                    promise.fulfill()
                }
            }
        
        // then
        wait(for: [promise], timeout: networkTimeout)
    }
    
    func testRxDecodedResponseError() throws {
        
        // given
        MockURLProtocol.requestHandler = { request in
            return (
                MockResponse.mockResponse(withURL: request.url!, statusCode: 999),
                MockResponse.mockResponseDemoData,
                nil
            )
        }
        
        let request = API.Mock.getRequest.urlRequest!
        let promise = expectation(description: "Status code: unknown")
        
        // when
        subscription = sut.run(request)
            .sink { completion in
                if case let .failure(error) = completion, error == .unknown {
                    promise.fulfill()
                } else {
                    XCTFail("Error: Request must fail with unknown error")
                }
            } receiveValue: { _ in
                XCTFail("Error: Request must fail")
            }
        
        // then
        wait(for: [promise], timeout: networkTimeout)
    }
    
    func testRxResponseDecodingError() throws {
        
        // given
        MockURLProtocol.requestHandler = { request in
            return (
                MockResponse.mockResponse(withURL: request.url!, statusCode: 200),
                MockResponse.mockResponseDemoData,
                nil
            )
        }
        
        let request = API.Mock.getRequest.urlRequest!
        let promise = expectation(description: "Decoding Error")
        
        // when
        subscription = sut.run(request)
            .sink { completion in
                if case let .failure(error) = completion, error == .decoding {
                    promise.fulfill()
                } else {
                    XCTFail("Error: Request must fail with decoding error")
                }
            } receiveValue: { (value: String) in
                XCTFail("Error: Request must fail")
            }
        
        // then
        wait(for: [promise], timeout: networkTimeout)
    }
    
    func testRxResponseStatusCode400() throws {
        
        // given
        MockURLProtocol.requestHandler = { request in
            return (
                MockResponse.mockResponse(withURL: request.url!, statusCode: 400),
                MockResponse.mockResponseEmptyData,
                nil
            )
        }
        
        let request = API.Mock.getRequest.urlRequest!
        let promise = expectation(description: "Status code: 400")
        
        // when
        subscription = sut.run(request)
            .sink { completion in
                if case let .failure(error) = completion, error == .badRequest {
                    promise.fulfill()
                } else {
                    XCTFail("Error: Request must fail with badRequest error")
                }
            } receiveValue: { _ in
                XCTFail("Error: Request must fail")
            }
        
        // then
        wait(for: [promise], timeout: networkTimeout)
    }
    
    func testRxResponseStatusCode401() throws {
        
        // given
        MockURLProtocol.requestHandler = { request in
            return (
                MockResponse.mockResponse(withURL: request.url!, statusCode: 401),
                MockResponse.mockResponseEmptyData,
                nil
            )
        }
        
        let request = API.Mock.getRequest.urlRequest!
        let promise = expectation(description: "Status code: 401")
        
        // when
        subscription = sut.run(request)
            .sink { completion in
                if case let .failure(error) = completion, error == .unauthorized {
                    promise.fulfill()
                } else {
                    XCTFail("Error: Request must fail with unauthorized error")
                }
            } receiveValue: { _ in
                XCTFail("Error: Request must fail")
            }
        
        // then
        wait(for: [promise], timeout: networkTimeout)
    }
    
    func testRxResponseStatusCode403() throws {
        
        // given
        MockURLProtocol.requestHandler = { request in
            return (
                MockResponse.mockResponse(withURL: request.url!, statusCode: 403),
                MockResponse.mockResponseEmptyData,
                nil
            )
        }
        
        let request = API.Mock.getRequest.urlRequest!
        let promise = expectation(description: "Status code: 403")
        
        // when
        subscription = sut.run(request)
            .sink { completion in
                if case let .failure(error) = completion, error == .forbidden {
                    promise.fulfill()
                } else {
                    XCTFail("Error: Request must fail with forbidden error")
                }
            } receiveValue: { _ in
                XCTFail("Error: Request must fail")
            }
        
        // then
        wait(for: [promise], timeout: networkTimeout)
    }
    
    func testRxResponseStatusCode404() throws {
        
        // given
        MockURLProtocol.requestHandler = { request in
            return (
                MockResponse.mockResponse(withURL: request.url!, statusCode: 404),
                MockResponse.mockResponseEmptyData,
                nil
            )
        }
        
        let request = API.Mock.getRequest.urlRequest!
        let promise = expectation(description: "Status code: 404")
        
        // when
        subscription = sut.run(request)
            .sink { completion in
                if case let .failure(error) = completion, error == .notFound {
                    promise.fulfill()
                } else {
                    XCTFail("Error: Request must fail with notFound error")
                }
            } receiveValue: { _ in
                XCTFail("Error: Request must fail")
            }
        
        // then
        wait(for: [promise], timeout: networkTimeout)
    }
    
    func testRxResponseStatusCode409() throws {
        
        // given
        MockURLProtocol.requestHandler = { request in
            return (
                MockResponse.mockResponse(withURL: request.url!, statusCode: 409),
                MockResponse.mockResponseEmptyData,
                nil
            )
        }
        
        let request = API.Mock.getRequest.urlRequest!
        let promise = expectation(description: "Status code: 409")
        
        // when
        subscription = sut.run(request)
            .sink { completion in
                if case let .failure(error) = completion, error == .conflict {
                    promise.fulfill()
                } else {
                    XCTFail("Error: Request must fail with conflict error")
                }
            } receiveValue: { _ in
                XCTFail("Error: Request must fail")
            }
        
        // then
        wait(for: [promise], timeout: networkTimeout)
    }
    
    func testRxResponseStatusCode429() throws {
        
        // given
        MockURLProtocol.requestHandler = { request in
            return (
                MockResponse.mockResponse(withURL: request.url!, statusCode: 429),
                MockResponse.mockResponseEmptyData,
                nil
            )
        }
        
        let request = API.Mock.getRequest.urlRequest!
        let promise = expectation(description: "Status code: 429")
        
        // when
        subscription = sut.run(request)
            .sink { completion in
                if case let .failure(error) = completion, error == .tooManyRequests {
                    promise.fulfill()
                } else {
                    XCTFail("Error: Request must fail with tooManyRequests error")
                }
            } receiveValue: { _ in
                XCTFail("Error: Request must fail")
            }
        
        // then
        wait(for: [promise], timeout: networkTimeout)
    }
    
    func testRxResponseStatusCode500() throws {
        
        // given
        MockURLProtocol.requestHandler = { request in
            return (
                MockResponse.mockResponse(withURL: request.url!, statusCode: 500),
                MockResponse.mockResponseEmptyData,
                nil
            )
        }
        
        let request = API.Mock.getRequest.urlRequest!
        let promise = expectation(description: "Status code: 500")
        
        // when
        subscription = sut.run(request)
            .sink { completion in
                if case let .failure(error) = completion, error == .server {
                    promise.fulfill()
                } else {
                    XCTFail("Error: Request must fail with server error")
                }
            } receiveValue: { _ in
                XCTFail("Error: Request must fail")
            }
        
        // then
        wait(for: [promise], timeout: networkTimeout)
    }
    
    func testRxResponseStatusCode503() throws {
        
        // given
        MockURLProtocol.requestHandler = { request in
            return (
                MockResponse.mockResponse(withURL: request.url!, statusCode: 503),
                MockResponse.mockResponseEmptyData,
                nil
            )
        }
        
        let request = API.Mock.getRequest.urlRequest!
        let promise = expectation(description: "Status code: 503")
        
        // when
        subscription = sut.run(request)
            .sink { completion in
                if case let .failure(error) = completion, error == .maintenanceMode {
                    promise.fulfill()
                } else {
                    XCTFail("Error: Request must fail with maintenanceMode error")
                }
            } receiveValue: { _ in
                XCTFail("Error: Request must fail")
            }
        
        // then
        wait(for: [promise], timeout: networkTimeout)
    }
    
    func testRxResponseStatusCodeUnknown() throws {
        
        // given
        MockURLProtocol.requestHandler = { request in
            return (
                MockResponse.mockResponse(withURL: request.url!, statusCode: 415),
                MockResponse.mockResponseEmptyData,
                nil
            )
        }
        
        let request = API.Mock.getRequest.urlRequest!
        let promise = expectation(description: "Status code: Unknown")
        
        // when
        subscription = sut.run(request)
            .sink { completion in
                if case let .failure(error) = completion, error == .unknown {
                    promise.fulfill()
                } else {
                    XCTFail("Error: Request must fail with unknown error")
                }
            } receiveValue: { _ in
                XCTFail("Error: Request must fail")
            }
        
        // then
        wait(for: [promise], timeout: networkTimeout)
    }
}
