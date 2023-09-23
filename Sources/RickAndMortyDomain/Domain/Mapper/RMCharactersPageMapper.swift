//
//  RMCharactersPageMapper.swift
//  
//
//  Created by Manu Rico on 23/9/23.
//

import Foundation

extension PaginatedEntity<[CharacterEntity]> {
    
    func toDomain() -> RMCharactersPage {
        .init(
            pages: info?.pages ?? .zero,
            prev: info?.prev?.extractIdParameter(),
            next: info?.next?.extractIdParameter(),
            characters: results?.map { $0.toDomain() } ?? []
        )
    }
}
