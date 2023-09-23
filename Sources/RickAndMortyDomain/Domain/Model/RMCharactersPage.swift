//
//  RMCharactersPage.swift
//  
//
//  Created by Manu Rico on 23/9/23.
//

import Foundation

public struct RMCharactersPage: Model {

    public let pages: Int
    public let prev: Int?
    public let next: Int?
    public let characters: [RMCharacter]
}

public extension RMCharactersPage {
    
    static var empty: Self {
        .init(
            pages: .zero,
            prev: nil,
            next: nil,
            characters: []
        )
    }
    
    static var mock: Self {
        .init(
            pages: 1,
            prev: nil,
            next: nil,
            characters: RMCharacter.mockList
        )
    }
}
