//
//  MockAPI.swift
//
//
//  Created by Manu Rico on 15/10/23.
//

import Foundation
@testable import RickAndMortyDomain

extension API {
    
    enum Mock: URLRequestConvertible {
        
        case getRequest
        
        var method: HttpConstants.Method {
            switch self {
            case .getRequest:
                return .get
            }
        }
        
        var endpoint: URL? {
            switch self {
            case .getRequest:
                return URL(string: HttpConstants.baseURL)
            }
        }
        
        func addHeaders(toRequest request: inout URLRequest) {
            // Intentionally empty
        }
        
        func addBody(toRequest request: inout URLRequest) {
            // Intentionally empty
        }
    }
}
