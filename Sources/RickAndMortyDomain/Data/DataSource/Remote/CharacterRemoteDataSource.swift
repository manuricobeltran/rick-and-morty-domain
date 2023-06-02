//
//  CharacterRemoteDataSource.swift
//  
//
//  Created by Manu Rico on 30/5/23.
//

import Foundation
import Combine

protocol CharacterRemoteDataSource {
    /// Reactive
    func getCharacter(withId id: Int) -> AnyPublisher<CharacterEntity, DataError>
    func getCharacters(withIds ids: [Int]) -> AnyPublisher<[CharacterEntity], DataError>
    func getAllCharacters(_ page: Int?) -> AnyPublisher<[CharacterEntity], DataError>
    /// Async
    func getCharacter(withId id: Int) async throws -> CharacterEntity
    func getCharacters(withIds ids: [Int]) async throws -> [CharacterEntity]
    func getAllCharacters(_ page: Int?) async throws -> [CharacterEntity]
}

final class CharacterRemoteDataSourceDefault: CharacterRemoteDataSource { }

// MARK: Reactive
extension CharacterRemoteDataSourceDefault {
    
    func getCharacter(withId id: Int) -> AnyPublisher<CharacterEntity, DataError> {
        guard let request = API.Character.getCharacters([id]).urlRequest else {
            return Fail(error: DataError.invalidUrl).eraseToAnyPublisher()
        }
        return NetworkDataSource.run(request)
    }
    
    func getCharacters(withIds ids: [Int]) -> AnyPublisher<[CharacterEntity], DataError> {
        guard let request = API.Character.getCharacters(ids).urlRequest else {
            return Fail(error: DataError.invalidUrl).eraseToAnyPublisher()
        }
        return NetworkDataSource.run(request)
    }
    
    func getAllCharacters(_ page: Int?) -> AnyPublisher<[CharacterEntity], DataError> {
        guard let request = API.Character.getAllCharacters(page).urlRequest else {
            return Fail(error: DataError.invalidUrl).eraseToAnyPublisher()
        }
        return NetworkDataSource.run(request)
    }
}

// MARK: Async
extension CharacterRemoteDataSourceDefault {
    
    func getCharacter(withId id: Int) async throws -> CharacterEntity {
        guard let request = API.Character.getCharacters([id]).urlRequest else {
            throw DataError.invalidUrl
        }
        return try await NetworkDataSource.run(request)
    }
    
    func getCharacters(withIds ids: [Int]) async throws -> [CharacterEntity] {
        guard let request = API.Character.getCharacters(ids).urlRequest else {
            throw DataError.invalidUrl
        }
        return try await NetworkDataSource.run(request)
    }
    
    func getAllCharacters(_ page: Int?) async throws -> [CharacterEntity] {
        guard let request = API.Character.getAllCharacters(page).urlRequest else {
            throw DataError.invalidUrl
        }
        return try await NetworkDataSource.run(request)
    }
}
