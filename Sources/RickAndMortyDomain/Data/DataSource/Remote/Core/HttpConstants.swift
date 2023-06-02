//
//  HttpConstants.swift
//  
//
//  Created by Manu Rico on 27/5/23.
//

import Foundation

enum HttpConstants {
    
    static let baseURL: String = "https://rickandmortyapi.com/api"
}

extension HttpConstants {
    
    enum Method: String {
        
        case get = "GET"
        case post = "POST"
        case patch = "PATCH"
        case put = "PUT"
        case delete = "DELETE"
    }

    enum Header {
        
        static let contentType = "Content-Type"
        static let accept = "Accept"
    }
    
    enum HeaderValue {
        
        static let applicationJson = "application/json"
        static let all = "*/*"
    }
}
