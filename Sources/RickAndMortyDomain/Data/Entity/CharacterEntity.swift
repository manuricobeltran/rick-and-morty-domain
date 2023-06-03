//
//  CharacterEntity.swift
//  
//
//  Created by Manu Rico on 30/5/23.
//

import Foundation

struct CharacterEntity: Entity {
    let id: Int?
    let name: String?
    let status: String?
    let species: String?
    let type: String?
    let gender: String?
    let origin: CharacterLocationEntity?
    let location: CharacterLocationEntity?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}

struct CharacterLocationEntity: Entity {
    let name: String?
    let url: String?
}
