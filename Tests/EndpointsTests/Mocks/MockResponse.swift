//
//  MockResponse.swift
//
//
//  Created by Manu Rico on 16/10/23.
//

import Foundation

struct MockResponse {
    
    static let mockResponseEmptyData: Data? = "".data(using: .utf8)
    static let mockResponseDemoData: Data? = "{\"integer\" : 1, \"string\" : \"decodedString\"}".data(using: .utf8)
    
    static let mockDecodedString = "decodedString"
    static let mockDecodedInt = 1
    
    static func mockResponse(withURL url: URL, statusCode: Int) -> HTTPURLResponse? {
        HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)
    }
}
