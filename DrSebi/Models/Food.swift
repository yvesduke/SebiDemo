//
//  Dient.swift
//  DrSebi
//
//  Created by Yves Dukuze on 01/04/2025.
//

import Foundation

public struct Food: Codable, Equatable {
    public let id: Int
    public let name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

