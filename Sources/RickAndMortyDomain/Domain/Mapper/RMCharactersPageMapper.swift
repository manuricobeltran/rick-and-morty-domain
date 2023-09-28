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
            prev: info?.prev?.extractPageParameter(),
            next: info?.next?.extractPageParameter(),
            characters: results?.map { $0.toDomain() } ?? []
        )
    }
}
