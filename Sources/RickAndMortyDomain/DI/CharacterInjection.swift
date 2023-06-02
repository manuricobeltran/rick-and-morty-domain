//
//  RMInjectorProvider.swift
//  
//
//  Created by Manu Rico on 2/6/23.
//

import Foundation
import Factory

extension Container {
    
    var characterRemoteDataSource: Factory<CharacterRemoteDataSource> {
        self { CharacterRemoteDataSourceDefault() }.singleton
    }
    
    var characterRepository: Factory<CharacterRepository> {
        self {
            CharacterRepositoryDefault(remoteDataSource: self.characterRemoteDataSource())
        }.singleton
    }
}
