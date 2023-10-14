//
//  CharacterRemoteDataSource.swift
//  
//
//  Created by Manu Rico on 30/5/23.
//

import Combine

protocol CharacterRemoteDataSource {
    /// Reactive
    func getCharacter(withId id: Int) -> AnyPublisher<CharacterEntity, DataError>
    func getCharacters(withIds ids: [Int]) -> AnyPublisher<[CharacterEntity], DataError>
    func getAllCharacters(_ page: Int?) -> AnyPublisher<PaginatedEntity<[CharacterEntity]>, DataError>
    /// Async
    func getCharacter(withId id: Int) async throws -> CharacterEntity
    func getCharacters(withIds ids: [Int]) async throws -> [CharacterEntity]
    func getAllCharacters(_ page: Int?) async throws -> PaginatedEntity<[CharacterEntity]>
}

final class CharacterRemoteDataSourceDefault: CharacterRemoteDataSource { 
    
    private let network: NetworkManager
    
    init(withNetwork network: NetworkManager) {
        self.network = network
    }
}

// MARK: Reactive
extension CharacterRemoteDataSourceDefault {
    
    func getCharacter(withId id: Int) -> AnyPublisher<CharacterEntity, DataError> {
        guard let request = API.Character.getCharacters([id]).urlRequest else {
            return Fail(error: DataError.invalidUrl).eraseToAnyPublisher()
        }
        return network.run(request)
    }
    
    func getCharacters(withIds ids: [Int]) -> AnyPublisher<[CharacterEntity], DataError> {
        guard let request = API.Character.getCharacters(ids).urlRequest else {
            return Fail(error: DataError.invalidUrl).eraseToAnyPublisher()
        }
        return network.run(request)
    }
    
    func getAllCharacters(_ page: Int?) -> AnyPublisher<PaginatedEntity<[CharacterEntity]>, DataError> {
        guard let request = API.Character.getAllCharacters(page).urlRequest else {
            return Fail(error: DataError.invalidUrl).eraseToAnyPublisher()
        }
        return network.run(request)
    }
}

// MARK: Async
extension CharacterRemoteDataSourceDefault {
    
    func getCharacter(withId id: Int) async throws -> CharacterEntity {
        guard let request = API.Character.getCharacters([id]).urlRequest else {
            throw DataError.invalidUrl
        }
        return try await network.run(request)
    }
    
    func getCharacters(withIds ids: [Int]) async throws -> [CharacterEntity] {
        guard let request = API.Character.getCharacters(ids).urlRequest else {
            throw DataError.invalidUrl
        }
        return try await network.run(request)
    }
    
    func getAllCharacters(_ page: Int?) async throws -> PaginatedEntity<[CharacterEntity]> {
        guard let request = API.Character.getAllCharacters(page).urlRequest else {
            throw DataError.invalidUrl
        }
        return try await network.run(request)
    }
}
