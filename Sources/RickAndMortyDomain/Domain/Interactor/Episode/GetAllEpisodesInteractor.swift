//
//  GetAllEpisodesInteractor.swift
//
//
//  Created by Manu Rico on 29/9/23.
//

import Combine

public protocol GetAllEpisodesInteractor {
    func execute(page: Int?) -> AnyPublisher<RMEpisodesPage, GetEpisodeError>
    func execute(page: Int?) async throws -> RMEpisodesPage
}

public final class GetAllEpisodesInteractorDefault {
    
    private let repository: EpisodeRepository
    
    init(repository: EpisodeRepository) {
        self.repository = repository
    }
}

extension GetAllEpisodesInteractorDefault: GetAllEpisodesInteractor {
    
    public func execute(page: Int?) -> AnyPublisher<RMEpisodesPage, GetEpisodeError> {
        repository.getAllEpisodes(page)
            .map { $0.toDomain() }
            .mapError { GetEpisodeErrorMapper.map($0) }
            .eraseToAnyPublisher()
    }
    
    public func execute(page: Int?) async throws -> RMEpisodesPage {
        do {
            return try await repository.getAllEpisodes(page).toDomain()
        } catch let error as DataError {
            throw GetEpisodeErrorMapper.map(error)
        } catch {
            throw GetEpisodeError.undefined
        }
    }
}
