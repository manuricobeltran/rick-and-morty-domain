//
//  GetLocationErrorMapper.swift
//
//
//  Created by Manu Rico on 6/10/23.
//

import Foundation

enum GetLocationErrorMapper {
    
    static func map(_ error: DataError) -> GetLocationError {
        switch error {
        case .notFound:
            return .locationNotFound
        default:
            return .undefined
        }
    }
}
