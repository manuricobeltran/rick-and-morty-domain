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
    
    /// Extracts the page from the end of the url string.
    /// It will return 2 from "https://rickandmortyapi.com/api/character/?page=2"
    func extractPageParameter() -> Int? {
        Int(split(separator: "=").last ?? "")
    }
    
    /// Extracts the id from the end of the url string.
    /// It will return 2 from "https://rickandmortyapi.com/api/episode/2"
    func extractIdParameter() -> Int? {
        Int(split(separator: "/").last ?? "")
    }
}
