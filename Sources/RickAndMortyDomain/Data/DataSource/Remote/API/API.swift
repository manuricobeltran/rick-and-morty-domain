//
//  API.swift
//  
//
//  Created by Manu Rico on 27/5/23.
//

import Foundation

enum API {}

extension API {

    static func pageQuery(_ page: Int?) -> String {
        guard let page else {
            return ""
        }
        return "/?page=\(page)"
    }
}
