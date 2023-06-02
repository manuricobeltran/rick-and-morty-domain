//
//  URLRequestConvertible.swift
//  
//
//  Created by Manu Rico on 27/5/23.
//

import Foundation

protocol URLRequestConvertible {
    var method: HttpConstants.Method { get }
    var endpoint: URL? { get }
    
    func addHeaders(toRequest request: inout URLRequest)
    func addBody(toRequest request: inout URLRequest)
}

extension URLRequestConvertible {
    
    var urlRequest: URLRequest? { try? asURLRequest() }
    
    private func asURLRequest() throws -> URLRequest {
        guard let endpoint else { throw DataError.invalidUrl }
        var request: URLRequest = URLRequest(url: endpoint)
        request.httpMethod = method.rawValue
        addHeaders(toRequest: &request)
        addBody(toRequest: &request)
        return request
    }
}
