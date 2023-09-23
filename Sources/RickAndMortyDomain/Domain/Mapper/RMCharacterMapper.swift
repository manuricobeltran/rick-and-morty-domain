//
//  RMCharacterMapper.swift
//  
//
//  Created by Manu Rico on 3/6/23.
//

import Foundation

extension CharacterEntity {
    
    func toDomain() -> RMCharacter {
        .init(
            id: id ?? .zero,
            name: name ?? "",
            status: RMCharacterStatus(rawValue: status?.lowercased() ?? "") ?? .unknown,
            species: species ?? "",
            type: type ?? "",
            gender: RMCharacterGender(rawValue: gender?.lowercased() ?? "") ?? .unknown,
            origin: origin?.toDomain() ?? .empty,
            location: location?.toDomain() ?? .empty,
            image: URL(string: image ?? ""),
            episode: episode.map { $0.compactMap { Int($0) } } ?? [],
            created: created?.toDate() ?? .now
        )
    }
}

extension CharacterLocationEntity {
    
    func toDomain() -> RMCharacterLocation {
        .init(
            id: url?.extractIdParameter() ?? .zero,
            name: name ?? ""
        )
    }
}
