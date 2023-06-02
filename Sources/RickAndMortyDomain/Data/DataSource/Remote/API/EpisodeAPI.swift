//
//  EpisodeAPI.swift
//  
//
//  Created by Manu Rico on 28/5/23.
//

import Foundation

extension API {
 
    enum Episode: URLRequestConvertible {
        
        case getEpisodes(_ ids: [Int])
        case getAllEpisodes(_ page: Int?)
        
        var method: HttpConstants.Method {
            switch self {
            case .getEpisodes, .getAllEpisodes:
                return .get
            }
        }
        
        var endpoint: URL? {
            switch self {
            case .getEpisodes(let ids):
                let episodes = ids.map { "\($0)" }.joined(separator: ",")
                return URL(string: HttpConstants.baseURL + "/episode/\(episodes)")
            case .getAllEpisodes(let page):
                return URL(string: HttpConstants.baseURL + "/episode" + API.pageQuery(page))
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
