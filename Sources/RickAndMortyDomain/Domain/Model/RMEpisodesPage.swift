//
//  RMEpisodesPage.swift
//
//
//  Created by Manu Rico on 29/9/23.
//

import Foundation

public struct RMEpisodesPage: Model {
    public let pages: Int
    public let prev: Int?
    public let next: Int?
    public let episodes: [RMEpisode]
}

public extension RMEpisodesPage {
    
    static var empty: Self {
        .init(
            pages: .zero,
            prev: nil,
            next: nil,
            episodes: []
        )
    }
    
    static var mock: Self {
        .init(
            pages: 1,
            prev: nil,
            next: nil,
            episodes: RMEpisode.mockList
        )
    }
}
