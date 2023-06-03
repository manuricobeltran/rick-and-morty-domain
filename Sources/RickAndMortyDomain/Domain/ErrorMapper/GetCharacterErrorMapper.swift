//
//  GetCharacterErrorMapper.swift
//  
//
//  Created by Manu Rico on 3/6/23.
//

import Foundation

enum GetCharacterErrorMapper {
    
    static func map(_ error: DataError) -> GetCharacterError {
        switch error {
        case .notFound:
            return .characterNotFound
        default:
            return .undefined
        }
    }
}
