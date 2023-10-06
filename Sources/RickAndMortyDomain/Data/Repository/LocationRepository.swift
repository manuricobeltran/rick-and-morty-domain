//
//  LocationRepository.swift
//
//
//  Created by Manu Rico on 5/10/23.
//

import Combine

protocol LocationRepository {
    /// Reactive
    func getLocation(withId id: Int) -> AnyPublisher<LocationEntity, DataError>
    func getLocations(withIds ids: [Int]) -> AnyPublisher<[LocationEntity], DataError>
    func getAllLocations(_ page: Int?) -> AnyPublisher<PaginatedEntity<[LocationEntity]>, DataError>
    /// Async
    func getLocation(withId id: Int) async throws -> LocationEntity
    func getLocations(withIds ids: [Int]) async throws -> [LocationEntity]
    func getAllLocations(_ page: Int?) async throws -> PaginatedEntity<[LocationEntity]>
}

final class LocationRepositoryDefault: LocationRepository {
    
    private let remote: LocationRemoteDataSource
    
    init(remoteDataSource: LocationRemoteDataSource) {
        remote = remoteDataSource
    }
}

// MARK: Reactive
extension LocationRepositoryDefault {
    
    func getLocation(withId id: Int) -> AnyPublisher<LocationEntity, DataError> {
        remote.getLocation(withId: id)
    }
    
    func getLocations(withIds ids: [Int]) -> AnyPublisher<[LocationEntity], DataError> {
        guard !ids.isEmpty else {
            return Fail(error: DataError.invalidUrl).eraseToAnyPublisher()
        }
        if ids.count == 1, let id = ids.first {
            return remote.getLocation(withId: id).collect().eraseToAnyPublisher()
        }
        return remote.getLocations(withIds: ids)
    }
    
    func getAllLocations(_ page: Int?) -> AnyPublisher<PaginatedEntity<[LocationEntity]>, DataError> {
        remote.getAllLocations(page)
    }
}

// MARK: Async
extension LocationRepositoryDefault {
    
    func getLocation(withId id: Int) async throws -> LocationEntity {
        try await remote.getLocation(withId: id)
    }
    
    func getLocations(withIds ids: [Int]) async throws -> [LocationEntity] {
        guard !ids.isEmpty else {
            throw DataError.invalidUrl
        }
        if ids.count == 1, let id = ids.first {
            return try await [remote.getLocation(withId: id)]
        }
        return try await remote.getLocations(withIds: ids)
    }
    
    func getAllLocations(_ page: Int?) async throws -> PaginatedEntity<[LocationEntity]> {
        try await remote.getAllLocations(page)
    }
}
