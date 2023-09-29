//
//  RMEpisodeMapper.swift
//
//
//  Created by Manu Rico on 29/9/23.
//

import Foundation

extension EpisodeEntity {
    
    func toDomain() -> RMEpisode {
        .init(
            id: id ?? .zero,
            episode: episode ?? "",
            name: name ?? "",
            airDate: airDate?.toDate() ?? .now,
            characters: characters.map { $0.compactMap { $0.extractIdParameter() } } ?? []
        )
    }
}
