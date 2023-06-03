//
//  CharacterMapper.swift
//  
//
//  Created by Manu Rico on 3/6/23.
//

import Foundation

extension CharacterEntity {
    
    func toDomain() -> RMCharacter {
        RMCharacter(
            id: id ?? .zero,
            name: name ?? "",
            status: CharacterStatus(rawValue: status ?? "") ?? .unknown,
            species: species ?? "",
            type: type ?? "",
            gender: Gender(rawValue: gender ?? "") ?? .unknown,
            origin: origin?.toDomain() ?? .empty(),
            location: location?.toDomain() ?? .empty(),
            image: URL(string: image ?? ""),
            episode: episode.map { $0.compactMap { Int($0) } } ?? [],
            created: created?.toDate() ?? .now
        )
    }
}

extension CharacterLocationEntity {
    
    func toDomain() -> CharacterLocation {
        CharacterLocation(
            id: url?.extractIdParameter() ?? .zero,
            name: name ?? ""
        )
    }
}
