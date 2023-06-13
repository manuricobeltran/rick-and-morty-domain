//
//  GetAllCharactersInteractor.swift
//  
//
//  Created by Manu Rico on 3/6/23.
//

import Foundation
import Combine

public protocol GetAllCharactersInteractor {
    func execute(page: Int?) -> AnyPublisher<[RMCharacter], GetCharactersError>
    func execute(page: Int?) async throws -> [RMCharacter]
}

public final class GetAllCharactersInteractorDefault {
    
    private let repository: CharacterRepository
    
    init(repository: CharacterRepository) {
        self.repository = repository
    }
}

extension GetAllCharactersInteractorDefault: GetAllCharactersInteractor {
    
    public func execute(page: Int?) -> AnyPublisher<[RMCharacter], GetCharactersError> {
        repository.getAllCharacters(page)
            .map { $0.map { $0.toDomain() } }
            .mapError { GetCharactersErrorMapper.map($0) }
            .eraseToAnyPublisher()
    }
    
    public func execute(page: Int?) async throws -> [RMCharacter] {
        do {
            return try await repository.getAllCharacters(page).map { $0.toDomain() }
        } catch let error as DataError {
            throw GetCharactersErrorMapper.map(error)
        } catch {
            throw GetCharactersError.undefined
        }
    }
}
