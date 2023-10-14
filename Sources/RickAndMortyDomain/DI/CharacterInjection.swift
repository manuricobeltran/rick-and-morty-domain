//
//  CharacterInjection.swift
//  
//
//  Created by Manu Rico on 2/6/23.
//

import Foundation
import Factory

extension Container {
    
    var characterRemoteDataSource: Factory<CharacterRemoteDataSource> {
        self { CharacterRemoteDataSourceDefault(withNetwork: self.networkManager()) }.singleton
    }
    
    var characterRepository: Factory<CharacterRepository> {
        self {
            CharacterRepositoryDefault(remoteDataSource: self.characterRemoteDataSource())
        }.singleton
    }
    
    var getCharacterInteractor: Factory<GetCharacterInteractor> {
        self {
            GetCharacterInteractorDefault(repository: self.characterRepository())
        }.singleton
    }
    
    var getCharactersInteractor: Factory<GetCharactersInteractor> {
        self {
            GetCharactersInteractorDefault(repository: self.characterRepository())
        }.singleton
    }
    
    var getAllCharactersInteractor: Factory<GetAllCharactersInteractor> {
        self {
            GetAllCharactersInteractorDefault(repository: self.characterRepository())
        }.singleton
    }
}
