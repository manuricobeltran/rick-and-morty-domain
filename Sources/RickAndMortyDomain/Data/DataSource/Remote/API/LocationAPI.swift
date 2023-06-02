//
//  LocationAPI.swift
//  
//
//  Created by Manu Rico on 28/5/23.
//

import Foundation

extension API {
 
    enum Location: URLRequestConvertible {
        
        case getLocations(_ ids: [Int])
        case getAllLocations(_ page: Int?)
        
        var method: HttpConstants.Method {
            switch self {
            case .getLocations, .getAllLocations:
                return .get
            }
        }
        
        var endpoint: URL? {
            switch self {
            case .getLocations(let ids):
                let locations = ids.map { "\($0)" }.joined(separator: ",")
                return URL(string: HttpConstants.baseURL + "/location/\(locations)")
            case .getAllLocations(let page):
                return URL(string: HttpConstants.baseURL + "/location" + API.pageQuery(page))
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
