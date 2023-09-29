//
//  EpisodeInjection.swift
//
//
//  Created by Manu Rico on 29/9/23.
//

import Foundation
import Factory

extension Container {
    
    var episodeRemoteDataSource: Factory<EpisodeRemoteDataSource> {
        self { EpisodeRemoteDataSourceDefault() }.singleton
    }
    
    var episodeRepository: Factory<EpisodeRepository> {
        self {
            EpisodeRepositoryDefault(remoteDataSource: self.episodeRemoteDataSource())
        }.singleton
    }
    
    var getEpisodeInteractor: Factory<GetEpisodeInteractor> {
        self {
            GetEpisodeInteractorDefault(repository: self.episodeRepository())
        }.singleton
    }
    
    var getEpisodesInteractor: Factory<GetEpisodesInteractor> {
        self {
            GetEpisodesInteractorDefault(repository: self.episodeRepository())
        }.singleton
    }
    
    var getAllEpisodesInteractor: Factory<GetAllEpisodesInteractor> {
        self {
            GetAllEpisodesInteractorDefault(repository: self.episodeRepository())
        }.singleton
    }
}
