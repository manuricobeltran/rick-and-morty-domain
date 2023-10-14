//
//  LocationInjection.swift
//
//
//  Created by Manu Rico on 6/10/23.
//

import Foundation
import Factory

extension Container {
    
    var locationRemoteDataSource: Factory<LocationRemoteDataSource> {
        self { LocationRemoteDataSourceDefault(withNetwork: self.networkManager()) }.singleton
    }
    
    var locationRepository: Factory<LocationRepository> {
        self {
            LocationRepositoryDefault(remoteDataSource: self.locationRemoteDataSource())
        }.singleton
    }
    
    var getLocationInteractor: Factory<GetLocationInteractor> {
        self {
            GetLocationInteractorDefault(repository: self.locationRepository())
        }.singleton
    }
    
    var getLocationsInteractor: Factory<GetLocationsInteractor> {
        self {
            GetLocationsInteractorDefault(repository: self.locationRepository())
        }.singleton
    }
    
    var getAllLocationsInteractor: Factory<GetAllLocationsInteractor> {
        self {
            GetAllLocationsInteractorDefault(repository: self.locationRepository())
        }.singleton
    }
}
