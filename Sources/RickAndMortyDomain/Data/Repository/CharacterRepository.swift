//
//  CharacterRepository.swift
//  
//
//  Created by Manu Rico on 30/5/23.
//

import Foundation
import Combine

protocol CharacterRepository {
    /// Reactive
    func getCharacter(withId id: Int) -> AnyPublisher<CharacterEntity, DataError>
    func getCharacters(withIds ids: [Int]) -> AnyPublisher<[CharacterEntity], DataError>
    func getAllCharacters(_ page: Int?) -> AnyPublisher<PaginatedEntity<[CharacterEntity]>, DataError>
    /// Async
    func getCharacter(withId id: Int) async throws -> CharacterEntity
    func getCharacters(withIds ids: [Int]) async throws -> [CharacterEntity]
    func getAllCharacters(_ page: Int?) async throws -> PaginatedEntity<[CharacterEntity]>
}

final class CharacterRepositoryDefault: CharacterRepository {
    
    private let remote: CharacterRemoteDataSource
    
    init(remoteDataSource: CharacterRemoteDataSource) {
        remote = remoteDataSource
    }
}

// MARK: Reactive
extension CharacterRepositoryDefault {
    
    func getCharacter(withId id: Int) -> AnyPublisher<CharacterEntity, DataError> {
        remote.getCharacter(withId: id)
    }
    
    func getCharacters(withIds ids: [Int]) -> AnyPublisher<[CharacterEntity], DataError> {
        guard !ids.isEmpty else {
            return Fail(error: DataError.invalidUrl).eraseToAnyPublisher()
        }
        if ids.count == 1, let id = ids.first {
            return remote.getCharacter(withId: id).collect().eraseToAnyPublisher()
        }
        return remote.getCharacters(withIds: ids)
    }
    
    func getAllCharacters(_ page: Int?) -> AnyPublisher<PaginatedEntity<[CharacterEntity]>, DataError> {
        remote.getAllCharacters(page)
    }
}

// MARK: Async
extension CharacterRepositoryDefault {
    
    func getCharacter(withId id: Int) async throws -> CharacterEntity {
        try await remote.getCharacter(withId: id)
    }
    
    func getCharacters(withIds ids: [Int]) async throws -> [CharacterEntity] {
        guard !ids.isEmpty else {
            throw DataError.invalidUrl
        }
        if ids.count == 1, let id = ids.first {
            return try await [remote.getCharacter(withId: id)]
        }
        return try await remote.getCharacters(withIds: ids)
    }
    
    func getAllCharacters(_ page: Int?) async throws -> PaginatedEntity<[CharacterEntity]> {
        try await remote.getAllCharacters(page)
    }
}
