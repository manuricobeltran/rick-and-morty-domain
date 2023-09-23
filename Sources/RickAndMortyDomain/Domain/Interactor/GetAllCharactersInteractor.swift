//
//  GetAllCharactersInteractor.swift
//  
//
//  Created by Manu Rico on 3/6/23.
//

import Foundation
import Combine

public protocol GetAllCharactersInteractor {
    func execute(page: Int?) -> AnyPublisher<RMCharactersPage, GetCharactersError>
    func execute(page: Int?) async throws -> RMCharactersPage
}

public final class GetAllCharactersInteractorDefault {
    
    private let repository: CharacterRepository
    
    init(repository: CharacterRepository) {
        self.repository = repository
    }
}

extension GetAllCharactersInteractorDefault: GetAllCharactersInteractor {
    
    public func execute(page: Int?) -> AnyPublisher<RMCharactersPage, GetCharactersError> {
        repository.getAllCharacters(page)
            .map { $0.toDomain() }
            .mapError { GetCharactersErrorMapper.map($0) }
            .eraseToAnyPublisher()
    }
    
    public func execute(page: Int?) async throws -> RMCharactersPage {
        do {
            return try await repository.getAllCharacters(page).toDomain()
        } catch let error as DataError {
            throw GetCharactersErrorMapper.map(error)
        } catch {
            throw GetCharactersError.undefined
        }
    }
}
