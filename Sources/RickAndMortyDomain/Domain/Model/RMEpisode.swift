//
//  RMEpisode.swift
//
//
//  Created by Manu Rico on 29/9/23.
//

import Foundation

public struct RMEpisode: Model, Identifiable {
    public let id: Int
    public let episode: String
    public let name: String
    public let airDate: Date
    public let characters: [Int]
}

public extension RMEpisode {
    
    static var empty: Self {
        .init(
            id: .zero,
            episode: "",
            name: "",
            airDate: .now,
            characters: []
        )
    }
    
    static var mock: Self {
        .init(
            id: Int.random(in: .zero...Int.max),
            episode: "S01E01",
            name: "Episode name",
            airDate: .now,
            characters: [Int.random(in: .zero...Int.max)]
        )
    }
    
    static var mockList: [Self] {
        let listCount: Int = 20
        return .init(repeating: .mock, count: listCount)
    }
}
