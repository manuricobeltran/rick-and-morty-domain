//
//  GetCharacterInteractor.swift
//  
//
//  Created by Manu Rico on 3/6/23.
//

import Foundation
import Combine

public protocol GetCharacterInteractor {
    func execute(characterId: Int) -> AnyPublisher<RMCharacter, GetCharactersError>
    func execute(characterId: Int) async throws -> RMCharacter
}

public final class GetCharacterInteractorDefault {
    
    private let repository: CharacterRepository
    
    init(repository: CharacterRepository) {
        self.repository = repository
    }
}

extension GetCharacterInteractorDefault: GetCharacterInteractor {
    
    public func execute(characterId: Int) -> AnyPublisher<RMCharacter, GetCharactersError> {
        repository.getCharacter(withId: characterId)
            .map { $0.toDomain() }
            .mapError { GetCharactersErrorMapper.map($0) }
            .eraseToAnyPublisher()
    }
    
    public func execute(characterId: Int) async throws -> RMCharacter {
        do {
            let character = try await repository.getCharacter(withId: characterId)
            return character.toDomain()
        } catch let error as DataError {
            throw GetCharactersErrorMapper.map(error)
        } catch {
            throw GetCharactersError.undefined
        }
    }
}
