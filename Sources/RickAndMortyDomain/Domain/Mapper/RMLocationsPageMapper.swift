//
//  RMLocationsPageMapper.swift
//
//
//  Created by Manu Rico on 6/10/23.
//

import Foundation

extension PaginatedEntity<[LocationEntity]> {
    
    func toDomain() -> RMLocationsPage {
        .init(
            pages: info?.pages ?? .zero,
            prev: info?.prev?.extractPageParameter(),
            next: info?.next?.extractPageParameter(),
            locations: results?.map { $0.toDomain() } ?? []
        )
    }
}
