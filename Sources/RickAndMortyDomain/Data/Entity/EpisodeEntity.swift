//
//  EpisodeEntity.swift
//  
//
//  Created by Manu Rico on 30/5/23.
//

import Foundation

struct EpisodeEntity: Entity {
    let id: Int?
    let name: String?
    let airDate: String?
    let episode: String?
    let characters: [String]?
    let url: String?
    let created: String?
}

extension EpisodeEntity {
    
    enum CodingKeys: String, CodingKey {
        case id, name, episode, characters, url, created
        case airDate = "air_date"
    }
}
