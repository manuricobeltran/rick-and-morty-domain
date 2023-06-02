//
//  URLRequest+Headers.swift
//  
//
//  Created by Manu Rico on 27/5/23.
//

import Foundation

extension URLRequest {
    
    mutating func addContentHeaders() {
        setValue(HttpConstants.HeaderValue.applicationJson, forHTTPHeaderField: HttpConstants.Header.contentType)
    }
}

extension URLRequest {
    
    mutating func addEncodedBody(withParams params: Encodable) {
        httpBody = try? JSONEncoder().encode(params)
    }
}
