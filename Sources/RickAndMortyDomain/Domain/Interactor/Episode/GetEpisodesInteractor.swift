//
//  GetEpisodesInteractor.swift
//  
//
//  Created by Manu Rico on 29/9/23.
//

import Combine

public protocol GetEpisodesInteractor {
    func execute(episodesIds: [Int]) -> AnyPublisher<[RMEpisode], GetEpisodeError>
    func execute(episodesIds: [Int]) async throws -> [RMEpisode]
}

public final class GetEpisodesInteractorDefault {
    
    private let repository: EpisodeRepository
    
    init(repository: EpisodeRepository) {
        self.repository = repository
    }
}

extension GetEpisodesInteractorDefault: GetEpisodesInteractor {
    
    public func execute(episodesIds: [Int]) -> AnyPublisher<[RMEpisode], GetEpisodeError> {
        repository.getEpisodes(withIds: episodesIds)
            .map { $0.map { $0.toDomain() } }
            .mapError { GetEpisodeErrorMapper.map($0) }
            .eraseToAnyPublisher()
    }
    
    public func execute(episodesIds: [Int]) async throws -> [RMEpisode] {
        do {
            let episodes = try await repository.getEpisodes(withIds: episodesIds)
            return episodes.map { $0.toDomain() }
        } catch let error as DataError {
            throw GetEpisodeErrorMapper.map(error)
        } catch {
            throw GetEpisodeError.undefined
        }
    }
}
