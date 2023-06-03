//
//  GetCharactersInteractor.swift
//
//
//  Created by Manu Rico on 3/6/23.
//

import Foundation
import Combine

public protocol GetCharactersInteractor {
    func execute(characterIds: [Int]) -> AnyPublisher<[RMCharacter], GetCharactersError>
    func execute(characterIds: [Int]) async throws -> [RMCharacter]
}

public final class GetCharactersInteractorDefault {
    
    private let repository: CharacterRepository
    
    init(repository: CharacterRepository) {
        self.repository = repository
    }
}

extension GetCharactersInteractorDefault: GetCharactersInteractor {
    
    public func execute(characterIds: [Int]) -> AnyPublisher<[RMCharacter], GetCharactersError> {
        repository.getCharacters(withIds: characterIds)
            .map { $0.map { $0.toDomain() } }
            .mapError { GetCharactersErrorMapper.map($0) }
            .eraseToAnyPublisher()
    }
    
    public func execute(characterIds: [Int]) async throws -> [RMCharacter] {
        do {
            let characters = try await repository.getCharacters(withIds: characterIds)
            return characters.map { $0.toDomain() }
        } catch let error as DataError {
            throw GetCharactersErrorMapper.map(error)
        } catch {
            throw GetCharactersError.undefined
        }
    }
}
