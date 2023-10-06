//
//  GetLocationInteractor.swift
//
//
//  Created by Manu Rico on 6/10/23.
//

import Combine

public protocol GetLocationInteractor {
    func execute(locationId: Int) -> AnyPublisher<RMLocation, GetLocationError>
    func execute(locationId: Int) async throws -> RMLocation
}

public final class GetLocationInteractorDefault {
    
    private let repository: LocationRepository
    
    init(repository: LocationRepository) {
        self.repository = repository
    }
}

extension GetLocationInteractorDefault: GetLocationInteractor {
    
    public func execute(locationId: Int) -> AnyPublisher<RMLocation, GetLocationError> {
        repository.getLocation(withId: locationId)
            .map { $0.toDomain() }
            .mapError { GetLocationErrorMapper.map($0) }
            .eraseToAnyPublisher()
    }
    
    public func execute(locationId: Int) async throws -> RMLocation {
        do {
            return try await repository.getLocation(withId: locationId).toDomain()
        } catch let error as DataError {
            throw GetLocationErrorMapper.map(error)
        } catch {
            throw GetLocationError.undefined
        }
    }
}
