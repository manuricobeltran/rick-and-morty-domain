//
//  RMLocation.swift
//
//
//  Created by Manu Rico on 6/10/23.
//

import Foundation

public struct RMLocation: Model, Identifiable {
    public let id: Int
    public let name: String
    public let type: String
    public let dimension: String
    public let residents: [Int]
}

public extension RMLocation {
    
    static var empty: Self {
        .init(
            id: .zero,
            name: "",
            type: "",
            dimension: "",
            residents: []
        )
    }
    
    static var mock: Self {
        .init(
            id: Int.random(in: .zero...Int.max),
            name: "Earth",
            type: "Planet",
            dimension: "Dimension C-137",
            residents: [Int.random(in: .zero...Int.max)]
        )
    }
    
    static var mockList: [Self] {
        let listCount: Int = 20
        return .init(repeating: .mock, count: listCount)
    }
}
