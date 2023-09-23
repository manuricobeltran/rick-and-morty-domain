//
//  PaginatedEntity.swift
//  
//
//  Created by Manu Rico on 19/9/23.
//

import Foundation

struct PaginatedEntity<R: Decodable>: Decodable {
    let info: PageInfo?
    let results: R?
}

struct PageInfo: Decodable {
    let count: Int?
    let pages: Int?
    let next: String?
    let prev: String?
}
