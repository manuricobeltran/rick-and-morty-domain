//
//  GetPaginatedCharactersInteractor.swift
//  
//
//  Created by Manu Rico on 18/6/23.
//

import Foundation
import Combine

public protocol GetPaginatedCharactersInteractor {
    var publisher: AnyPublisher<[RMCharacter], GetCharactersError> { get }
    
    func loadMore() async
}

public final class GetPaginatedCharactersInteractorDefault {
    private let repository: CharacterRepository
    
    private let subject = CurrentValueSubject<[RMCharacter], GetCharactersError>([])
    private var page: Int?
    private var moreDataAvailable: Bool = true
    
    init(repository: CharacterRepository) {
        self.repository = repository
        Task { await loadMore() }
    }
}

extension GetPaginatedCharactersInteractorDefault: GetPaginatedCharactersInteractor {
    
    public var publisher: AnyPublisher<[RMCharacter], GetCharactersError> {
        subject
            .eraseToAnyPublisher()
    }
    
    public func loadMore() async {
        guard moreDataAvailable
        else { return }
        do {
            let characters = try await repository.getAllCharacters(page).map { $0.toDomain() }
            if characters.isEmpty {
                moreDataAvailable = false
                subject.send(completion: .finished)
            } else {
                subject.send(characters)
            }
        } catch let error as DataError {
            let error = GetCharactersErrorMapper.map(error)
            moreDataAvailable = false
            subject.send(completion: .failure(error))
        } catch {
            moreDataAvailable = false
            subject.send(completion: .failure(.undefined))
        }
    }
}
