//
//  RMCharacter.swift
//  
//
//  Created by Manu Rico on 3/6/23.
//

import Foundation

public struct RMCharacter: Model {
    public let id: Int
    public let name: String
    public let status: CharacterStatus
    public let species: String
    public let type: String
    public let gender: Gender
    public let origin: CharacterLocation
    public let location: CharacterLocation
    public let image: URL?
    public let episode: [Int]
    public let created: Date
    
    static func empty() -> Self {
        .init(
            id: .zero,
            name: "",
            status: .unknown,
            species: "",
            type: "",
            gender: .unknown,
            origin: .empty(),
            location: .empty(),
            image: nil,
            episode: [],
            created: .now
        )
    }
}

public struct CharacterLocation: Model {
    public let id: Int
    public let name: String
    
    static func empty() -> Self {
        .init(id: .zero, name: "")
    }
}

public enum CharacterStatus: String, Model {
    case Alive
    case Dead
    case unknown
}

public enum Gender: String, Model {
    case Female
    case Male
    case Genderless
    case unknown
}
