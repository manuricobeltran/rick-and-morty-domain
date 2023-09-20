//
//  RMCharacter.swift
//  
//
//  Created by Manu Rico on 3/6/23.
//

import Foundation

public struct RMCharacter: Model, Identifiable {
    public let id: Int
    public let name: String
    public let status: RMCharacterStatus
    public let species: String
    public let type: String
    public let gender: RMCharacterGender
    public let origin: RMCharacterLocation
    public let location: RMCharacterLocation
    public let image: URL?
    public let episode: [Int]
    public let created: Date
}

public extension RMCharacter {
    
    public static var empty: Self {
        .init(
            id: .zero,
            name: "",
            status: .unknown,
            species: "",
            type: "",
            gender: .unknown,
            origin: .empty,
            location: .empty,
            image: nil,
            episode: [],
            created: .now
        )
    }
    
    public static var mock: Self {
        .init(
            id: Int.random(in: .zero...Int.max),
            name: "Character name",
            status: .alive,
            species: "Species",
            type: "Type",
            gender: .male,
            origin: .mock,
            location: .mock,
            image: nil,
            episode: [Int.random(in: .zero...Int.max)],
            created: .now
        )
    }
}

public struct RMCharacterLocation: Model {
    public let id: Int
    public let name: String
}

public extension RMCharacterLocation {
    
    public static var empty: Self {
        .init(id: .zero, name: "")
    }
    
    public static var mock: Self {
        .init(
            id: Int.random(in: .zero...Int.max),
            name: "Character location"
        )
    }
}

public enum RMCharacterStatus: String, Model {
    case alive
    case dead
    case unknown
}

public enum RMCharacterGender: String, Model {
    case female
    case male
    case genderless
    case unknown
}
