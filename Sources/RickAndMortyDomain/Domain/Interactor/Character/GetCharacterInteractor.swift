//
//  GetCharacterInteractor.swift
//  
//
//  Created by Manu Rico on 3/6/23.
//

import Combine

public protocol GetCharacterInteractor {
    func execute(characterId: Int) -> AnyPublisher<RMCharacter, GetCharacterError>
    func execute(characterId: Int) async throws -> RMCharacter
}

public final class GetCharacterInteractorDefault {
    
    private let repository: CharacterRepository
    
    init(repository: CharacterRepository) {
        self.repository = repository
    }
}

extension GetCharacterInteractorDefault: GetCharacterInteractor {
    
    public func execute(characterId: Int) -> AnyPublisher<RMCharacter, GetCharacterError> {
        repository.getCharacter(withId: characterId)
            .map { $0.toDomain() }
            .mapError { GetCharacterErrorMapper.map($0) }
            .eraseToAnyPublisher()
    }
    
    public func execute(characterId: Int) async throws -> RMCharacter {
        do {
            return try await repository.getCharacter(withId: characterId).toDomain()
        } catch let error as DataError {
            throw GetCharacterErrorMapper.map(error)
        } catch {
            throw GetCharacterError.undefined
        }
    }
}
