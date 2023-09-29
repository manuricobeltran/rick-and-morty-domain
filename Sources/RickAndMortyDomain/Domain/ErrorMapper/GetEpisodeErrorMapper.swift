//
//  GetEpisodeErrorMapper.swift
//
//
//  Created by Manu Rico on 29/9/23.
//

import Foundation

enum GetEpisodeErrorMapper {
    
    static func map(_ error: DataError) -> GetEpisodeError {
        switch error {
        case .notFound:
            return .episodeNotFound
        default:
            return .undefined
        }
    }
}
