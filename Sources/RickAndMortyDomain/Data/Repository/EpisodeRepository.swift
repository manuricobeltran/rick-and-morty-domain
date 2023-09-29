//
//  EpisodeRepository.swift
//
//
//  Created by Manu Rico on 29/9/23.
//

import Combine

protocol EpisodeRepository {
    /// Reactive
    func getEpisode(withId id: Int) -> AnyPublisher<EpisodeEntity, DataError>
    func getEpisodes(withIds ids: [Int]) -> AnyPublisher<[EpisodeEntity], DataError>
    func getAllEpisodes(_ page: Int?) -> AnyPublisher<PaginatedEntity<[EpisodeEntity]>, DataError>
    /// Async
    func getEpisode(withId id: Int) async throws -> EpisodeEntity
    func getEpisodes(withIds ids: [Int]) async throws -> [EpisodeEntity]
    func getAllEpisodes(_ page: Int?) async throws -> PaginatedEntity<[EpisodeEntity]>
}

final class EpisodeRepositoryDefault: EpisodeRepository {
    
    private let remote: EpisodeRemoteDataSource
    
    init(remoteDataSource: EpisodeRemoteDataSource) {
        remote = remoteDataSource
    }
}

// MARK: Reactive
extension EpisodeRepositoryDefault {
    
    func getEpisode(withId id: Int) -> AnyPublisher<EpisodeEntity, DataError> {
        remote.getEpisode(withId: id)
    }
    
    func getEpisodes(withIds ids: [Int]) -> AnyPublisher<[EpisodeEntity], DataError> {
        guard !ids.isEmpty else {
            return Fail(error: DataError.invalidUrl).eraseToAnyPublisher()
        }
        return remote.getEpisodes(withIds: ids)
    }
    
    func getAllEpisodes(_ page: Int?) -> AnyPublisher<PaginatedEntity<[EpisodeEntity]>, DataError> {
        remote.getAllEpisodes(page)
    }
}

// MARK: Async
extension EpisodeRepositoryDefault {
    
    func getEpisode(withId id: Int) async throws -> EpisodeEntity {
        try await remote.getEpisode(withId: id)
    }
    
    func getEpisodes(withIds ids: [Int]) async throws -> [EpisodeEntity] {
        guard !ids.isEmpty else {
            throw DataError.invalidUrl
        }
        return try await remote.getEpisodes(withIds: ids)
    }
    
    func getAllEpisodes(_ page: Int?) async throws -> PaginatedEntity<[EpisodeEntity]> {
        try await remote.getAllEpisodes(page)
    }
}
