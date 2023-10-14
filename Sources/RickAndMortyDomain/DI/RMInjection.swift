//
//  RMInjection.swift
//
//
//  Created by Manu Rico on 14/10/23.
//

import Foundation
import Factory

extension Container {
    
    var networkManager: Factory<NetworkManager> {
        self { NetworkManager() }.singleton
    }
}
