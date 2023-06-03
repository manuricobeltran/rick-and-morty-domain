//
//  String+.swift
//  
//
//  Created by Manu Rico on 3/6/23.
//

import Foundation

extension String {
    
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter.date(from: self)
    }
}

extension String {
    
    /// Extracts the id from the end of the url string.
    /// It will return 20 from "https://rickandmortyapi.com/api/location/20"
    func extractIdParameter() -> Int? {
        Int(split(separator: "/").last ?? "")
    }
}
