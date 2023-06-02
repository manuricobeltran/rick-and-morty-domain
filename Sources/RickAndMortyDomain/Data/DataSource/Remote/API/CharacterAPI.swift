//
//  CharacterAPI.swift
//  
//
//  Created by Manu Rico on 28/5/23.
//

import Foundation

extension API {
 
    enum Character: URLRequestConvertible {
        
        case getCharacters(_ ids: [Int])
        case getAllCharacters(_ page: Int?)
        
        var method: HttpConstants.Method {
            switch self {
            case .getCharacters, .getAllCharacters:
                return .get
            }
        }
        
        var endpoint: URL? {
            switch self {
            case .getCharacters(let ids):
                let characters = ids.map { "\($0)" }.joined(separator: ",")
                return URL(string: HttpConstants.baseURL + "/character/\(characters)")
            case .getAllCharacters(let page):
                return URL(string: HttpConstants.baseURL + "/character" + API.pageQuery(page))
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
