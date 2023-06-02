//
//  DataError.swift
//  
//
//  Created by Manu Rico on 30/5/23.
//

import Foundation

enum DataError: Error, Equatable {
    
    case invalidUrl
    case encoding
    case decoding
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case conflict
    case tooManyRequests
    case maintenanceMode
    case server
    case network
    case unknown
}
