//
//  RMLocationMapper.swift
//  
//
//  Created by Manu Rico on 6/10/23.
//

import Foundation

extension LocationEntity {
    
    func toDomain() -> RMLocation {
        .init(
            id: id ?? .zero,
            name: name ?? "",
            type: type ?? "",
            dimension: dimension ?? "",
            residents: residents.map { $0.compactMap { $0.extractIdParameter() } } ?? []
        )
    }
}
