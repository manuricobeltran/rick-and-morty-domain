//
//  GetEpisodeInteractor.swift
//
//
//  Created by Manu Rico on 29/9/23.
//

import Combine

public protocol GetEpisodeInteractor {
    func execute(episodeId: Int) -> AnyPublisher<RMEpisode, GetEpisodeError>
    func execute(episodeId: Int) async throws -> RMEpisode
}

public final class GetEpisodeInteractorDefault {
    
    private let repository: EpisodeRepository
    
    init(repository: EpisodeRepository) {
        self.repository = repository
    }
}

extension GetEpisodeInteractorDefault: GetEpisodeInteractor {
    
    public func execute(episodeId: Int) -> AnyPublisher<RMEpisode, GetEpisodeError> {
        repository.getEpisode(withId: episodeId)
            .map { $0.toDomain() }
            .mapError { GetEpisodeErrorMapper.map($0) }
            .eraseToAnyPublisher()
    }
    
    public func execute(episodeId: Int) async throws -> RMEpisode {
        do {
            return try await repository.getEpisode(withId: episodeId).toDomain()
        } catch let error as DataError {
            throw GetEpisodeErrorMapper.map(error)
        } catch {
            throw GetEpisodeError.undefined
        }
    }
}
