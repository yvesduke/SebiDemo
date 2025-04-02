//
//  Herb.swift
//  DrSebi
//
//  Created by Yves Dukuze on 01/04/2025.
//

import Foundation

struct Herb: Decodable, Equatable {
    let id: String
    let name: String
    let Description: String
    let avatar : String
    
    // Custom implementation of Equatable that only compares ID and name
    static func == (lhs: Herb, rhs: Herb) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}

