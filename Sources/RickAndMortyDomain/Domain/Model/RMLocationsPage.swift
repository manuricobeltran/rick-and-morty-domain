//
//  RMLocationsPage.swift
//
//
//  Created by Manu Rico on 6/10/23.
//

public struct RMLocationsPage: Model {
    public let pages: Int
    public let prev: Int?
    public let next: Int?
    public let locations: [RMLocation]
}

public extension RMLocationsPage {
    
    static var empty: Self {
        .init(
            pages: .zero,
            prev: nil,
            next: nil,
            locations: []
        )
    }
    
    static var mock: Self {
        .init(
            pages: 1,
            prev: nil,
            next: nil,
            locations: RMLocation.mockList
        )
    }
}
