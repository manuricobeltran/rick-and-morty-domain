//
//  EpisodeRemoteDataSource.swift
//
//
//  Created by Manu Rico on 29/9/23.
//

import Combine

protocol EpisodeRemoteDataSource {
    /// Reactive
    func getEpisode(withId id: Int) -> AnyPublisher<EpisodeEntity, DataError>
    func getEpisodes(withIds ids: [Int]) -> AnyPublisher<[EpisodeEntity], DataError>
    func getAllEpisodes(_ page: Int?) -> AnyPublisher<PaginatedEntity<[EpisodeEntity]>, DataError>
    /// Async
    func getEpisode(withId id: Int) async throws -> EpisodeEntity
    func getEpisodes(withIds ids: [Int]) async throws -> [EpisodeEntity]
    func getAllEpisodes(_ page: Int?) async throws -> PaginatedEntity<[EpisodeEntity]>
}

final class EpisodeRemoteDataSourceDefault: EpisodeRemoteDataSource { 
    
    private let network: NetworkManager
    
    init(withNetwork network: NetworkManager) {
        self.network = network
    }
}

// MARK: Reactive
extension EpisodeRemoteDataSourceDefault {
    
    func getEpisode(withId id: Int) -> AnyPublisher<EpisodeEntity, DataError> {
        guard let request = API.Episode.getEpisodes([id]).urlRequest else {
            return Fail(error: DataError.invalidUrl).eraseToAnyPublisher()
        }
        return network.run(request)
    }
    
    func getEpisodes(withIds ids: [Int]) -> AnyPublisher<[EpisodeEntity], DataError> {
        guard let request = API.Episode.getEpisodes(ids).urlRequest else {
            return Fail(error: DataError.invalidUrl).eraseToAnyPublisher()
        }
        return network.run(request)
    }
    
    func getAllEpisodes(_ page: Int?) -> AnyPublisher<PaginatedEntity<[EpisodeEntity]>, DataError> {
        guard let request = API.Episode.getAllEpisodes(page).urlRequest else {
            return Fail(error: DataError.invalidUrl).eraseToAnyPublisher()
        }
        return network.run(request)
    }
}

// MARK: Async
extension EpisodeRemoteDataSourceDefault {
    
    func getEpisode(withId id: Int) async throws -> EpisodeEntity {
        guard let request = API.Episode.getEpisodes([id]).urlRequest else {
            throw DataError.invalidUrl
        }
        return try await network.run(request)
    }
    
    func getEpisodes(withIds ids: [Int]) async throws -> [EpisodeEntity] {
        guard let request = API.Episode.getEpisodes(ids).urlRequest else {
            throw DataError.invalidUrl
        }
        return try await network.run(request)
    }
    
    func getAllEpisodes(_ page: Int?) async throws -> PaginatedEntity<[EpisodeEntity]> {
        guard let request = API.Episode.getAllEpisodes(page).urlRequest else {
            throw DataError.invalidUrl
        }
        return try await network.run(request)
    }
}
