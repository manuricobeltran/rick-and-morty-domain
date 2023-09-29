//
//  RMEpisodesPageMapper.swift
//
//
//  Created by Manu Rico on 29/9/23.
//

import Foundation

extension PaginatedEntity<[EpisodeEntity]> {
    
    func toDomain() -> RMEpisodesPage {
        .init(
            pages: info?.pages ?? .zero,
            prev: info?.prev?.extractPageParameter(),
            next: info?.next?.extractPageParameter(),
            episodes: results?.map { $0.toDomain() } ?? []
        )
    }
}
