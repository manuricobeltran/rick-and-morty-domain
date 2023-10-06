//
//  GetLocationsInteractor.swift
//  
//
//  Created by Manu Rico on 6/10/23.
//

import Combine

public protocol GetLocationsInteractor {
    func execute(locationsIds: [Int]) -> AnyPublisher<[RMLocation], GetLocationError>
    func execute(locationsIds: [Int]) async throws -> [RMLocation]
}

public final class GetLocationsInteractorDefault {
    
    private let repository: LocationRepository
    
    init(repository: LocationRepository) {
        self.repository = repository
    }
}

extension GetLocationsInteractorDefault: GetLocationsInteractor {
    
    public func execute(locationsIds: [Int]) -> AnyPublisher<[RMLocation], GetLocationError> {
        repository.getLocations(withIds: locationsIds)
            .map { $0.map { $0.toDomain() } }
            .mapError { GetLocationErrorMapper.map($0) }
            .eraseToAnyPublisher()
    }
    
    public func execute(locationsIds: [Int]) async throws -> [RMLocation] {
        do {
            let locations = try await repository.getLocations(withIds: locationsIds)
            return locations.map { $0.toDomain() }
        } catch let error as DataError {
            throw GetLocationErrorMapper.map(error)
        } catch {
            throw GetLocationError.undefined
        }
    }
}
