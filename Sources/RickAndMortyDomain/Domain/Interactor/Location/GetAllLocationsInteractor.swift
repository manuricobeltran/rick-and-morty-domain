//
//  GetAllLocationsInteractor.swift
//
//
//  Created by Manu Rico on 6/10/23.
//

import Combine

public protocol GetAllLocationsInteractor {
    func execute(page: Int?) -> AnyPublisher<RMLocationsPage, GetLocationError>
    func execute(page: Int?) async throws -> RMLocationsPage
}

public final class GetAllLocationsInteractorDefault {
    
    private let repository: LocationRepository
    
    init(repository: LocationRepository) {
        self.repository = repository
    }
}

extension GetAllLocationsInteractorDefault: GetAllLocationsInteractor {
    
    public func execute(page: Int?) -> AnyPublisher<RMLocationsPage, GetLocationError> {
        repository.getAllLocations(page)
            .map { $0.toDomain() }
            .mapError { GetLocationErrorMapper.map($0) }
            .eraseToAnyPublisher()
    }
    
    public func execute(page: Int?) async throws -> RMLocationsPage {
        do {
            return try await repository.getAllLocations(page).toDomain()
        } catch let error as DataError {
            throw GetLocationErrorMapper.map(error)
        } catch {
            throw GetLocationError.undefined
        }
    }
}
