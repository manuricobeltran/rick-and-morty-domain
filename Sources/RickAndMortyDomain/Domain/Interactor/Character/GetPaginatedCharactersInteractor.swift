//
//  GetPaginatedCharactersInteractor.swift
//  
//
//  Created by Manu Rico on 18/6/23.
//

import Combine

public protocol GetPaginatedCharactersInteractor {
    var publisher: AnyPublisher<[RMCharacter], GetCharacterError> { get }
    
    func loadMore() async
}

public final class GetPaginatedCharactersInteractorDefault {
    private let repository: CharacterRepository
    
    private let subject = CurrentValueSubject<[RMCharacter], GetCharacterError>([])
    private var page: Int?
    private var moreDataAvailable: Bool = true
    
    init(repository: CharacterRepository) {
        self.repository = repository
        Task { await loadMore() }
    }
}

extension GetPaginatedCharactersInteractorDefault: GetPaginatedCharactersInteractor {
    
    public var publisher: AnyPublisher<[RMCharacter], GetCharacterError> {
        subject
            .eraseToAnyPublisher()
    }
    
    public func loadMore() async {
        guard moreDataAvailable
        else { return }
        do {
            let charactersPage = try await repository.getAllCharacters(page).toDomain()
            if charactersPage.characters.isEmpty {
                moreDataAvailable = false
                subject.send(completion: .finished)
            } else {
                subject.send(charactersPage.characters)
            }
        } catch let error as DataError {
            let error = GetCharacterErrorMapper.map(error)
            moreDataAvailable = false
            subject.send(completion: .failure(error))
        } catch {
            moreDataAvailable = false
            subject.send(completion: .failure(.undefined))
        }
    }
}
