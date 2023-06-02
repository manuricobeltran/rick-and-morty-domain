//
//  NetworkDataSource.swift
//  
//
//  Created by Manu Rico on 28/5/23.
//

import Foundation
import Combine

struct NetworkDataSource {
    // swiftlint:disable no_magic_numbers
    private static let statusCodeOk = 200...299
    private static let statusCodeBadRequest = 400
    private static let statusCodeUnauthorized = 401
    private static let statusCodeForbidden = 403
    private static let statusCodeNotFound = 404
    private static let statusCodeConflict = 409
    private static let statusTooManyRequests = 429
    private static let statusCodeMaintenance = 503
    private static let statusCodeServerError = 500...599
    // swiftlint:enable no_magic_numbers
    
    private init() {
        // Intentionally empty
    }
}

// MARK: Reactive methods
extension NetworkDataSource {
    
    static func run(_ urlRequest: URLRequest) -> AnyPublisher<Void, DataError> {
        URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .tryMap { _, response -> Void in
                try processResponse(response)
            }
            .mapError { error in
                error as? DataError ?? .unknown
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func run<D: Decodable>(_ urlRequest: URLRequest) -> AnyPublisher<D, DataError> {
        URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .tryMap { data, response -> Data in
                try processResponse(response, data: data)
                return data
            }
            .decode(type: D.self, decoder: JSONDecoder())
            .mapError { error in
                error as? DataError ?? .decoding
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

// MARK: Async methods

extension NetworkDataSource {
    
    static func run(_ urlRequest: URLRequest) async throws {
        do {
            let (_, response) = try await URLSession.shared.data(for: urlRequest)
            try processResponse(response)
        } catch {
            throw error as? DataError ?? .unknown
        }
    }
    
    static func run<D: Decodable>(_ urlRequest: URLRequest) async throws -> D {
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            try processResponse(response)
            return try JSONDecoder().decode(D.self, from: data)
        } catch {
            throw error as? DataError ?? .unknown
        }
    }
}

// MARK: Error mapping

private extension NetworkDataSource {

    static func processResponse(_ response: URLResponse, data: Data? = nil) throws {
        if
            let response: HTTPURLResponse = response as? HTTPURLResponse,
            let error = checkStatusCodeFromResponse(response) {
                throw error
        }
    }

    static func checkStatusCodeFromResponse(_ response: HTTPURLResponse) -> DataError? {
        var error: DataError?
        switch response.statusCode {
        case statusCodeOk:
            break
        case statusCodeBadRequest:
            error = .badRequest
        case statusCodeUnauthorized:
            error = .unauthorized
        case statusCodeForbidden:
            error = .forbidden
        case statusCodeNotFound:
            error = .notFound
        case statusCodeConflict:
            error = .conflict
        case statusTooManyRequests:
            error = .tooManyRequests
        case statusCodeMaintenance:
            error = .maintenanceMode
        case statusCodeServerError:
            error = .server
        default:
            error = .unknown
        }
        return error
    }
}
