//
//  LocationRemoteDataSource.swift
//
//
//  Created by Manu Rico on 5/10/23.
//

import Combine

protocol LocationRemoteDataSource {
    /// Reactive
    func getLocation(withId id: Int) -> AnyPublisher<LocationEntity, DataError>
    func getLocations(withIds ids: [Int]) -> AnyPublisher<[LocationEntity], DataError>
    func getAllLocations(_ page: Int?) -> AnyPublisher<PaginatedEntity<[LocationEntity]>, DataError>
    /// Async
    func getLocation(withId id: Int) async throws -> LocationEntity
    func getLocations(withIds ids: [Int]) async throws -> [LocationEntity]
    func getAllLocations(_ page: Int?) async throws -> PaginatedEntity<[LocationEntity]>
}

final class LocationRemoteDataSourceDefault: LocationRemoteDataSource { }

// MARK: Reactive
extension LocationRemoteDataSourceDefault {
    
    func getLocation(withId id: Int) -> AnyPublisher<LocationEntity, DataError> {
        guard let request = API.Location.getLocations([id]).urlRequest else {
            return Fail(error: DataError.invalidUrl).eraseToAnyPublisher()
        }
        return NetworkDataSource.run(request)
    }
    
    func getLocations(withIds ids: [Int]) -> AnyPublisher<[LocationEntity], DataError> {
        guard let request = API.Location.getLocations(ids).urlRequest else {
            return Fail(error: DataError.invalidUrl).eraseToAnyPublisher()
        }
        return NetworkDataSource.run(request)
    }
    
    func getAllLocations(_ page: Int?) -> AnyPublisher<PaginatedEntity<[LocationEntity]>, DataError> {
        guard let request = API.Location.getAllLocations(page).urlRequest else {
            return Fail(error: DataError.invalidUrl).eraseToAnyPublisher()
        }
        return NetworkDataSource.run(request)
    }
}

// MARK: Async
extension LocationRemoteDataSourceDefault {
    
    func getLocation(withId id: Int) async throws -> LocationEntity {
        guard let request = API.Location.getLocations([id]).urlRequest else {
            throw DataError.invalidUrl
        }
        return try await NetworkDataSource.run(request)
    }
    
    func getLocations(withIds ids: [Int]) async throws -> [LocationEntity] {
        guard let request = API.Location.getLocations(ids).urlRequest else {
            throw DataError.invalidUrl
        }
        return try await NetworkDataSource.run(request)
    }
    
    func getAllLocations(_ page: Int?) async throws -> PaginatedEntity<[LocationEntity]> {
        guard let request = API.Location.getAllLocations(page).urlRequest else {
            throw DataError.invalidUrl
        }
        return try await NetworkDataSource.run(request)
    }
}
