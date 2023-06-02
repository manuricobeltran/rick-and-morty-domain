//
//  Entity.swift
//  
//
//  Created by Manu Rico on 30/5/23.
//

import Foundation

protocol Entity: Codable {}

struct EmptyEntity: Entity {}

struct EntityWithHeaders<D: Codable, H: Codable>: Entity {
    var data: D?
    var headers: H?
}
