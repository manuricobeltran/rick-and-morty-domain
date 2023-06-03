//
//  GetCharactersErrorMapper.swift
//  
//
//  Created by Manu Rico on 3/6/23.
//

import Foundation

enum GetCharactersErrorMapper {
    
    static func map(_ error: DataError) -> GetCharactersError {
        switch error {
        case .notFound:
            return .characterNotFound
        default:
            return .undefined
        }
    }
}
