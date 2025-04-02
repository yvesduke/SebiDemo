//
//  FoodClientKey.swift
//  DrSebi
//
//  Created by Yves Dukuze on 01/04/2025.
//

import ComposableArchitecture
import Foundation

public struct FoodClient {
    public var fetchFoods: @Sendable () async throws -> [Food]
}

extension FoodClient: DependencyKey {
    public static let liveValue: FoodClient = FoodClient(
        fetchFoods: { 
            let client = LiveFoodClient()
            return try await client.fetchFoods() 
        }
    )
    
    public static let testValue: FoodClient = FoodClient(
        fetchFoods: {
            return [
                Food(id: 1, name: "Amaranth")
            ]
        }
    )
}

extension DependencyValues {
    public var foodClient: FoodClient {
        get { self[FoodClient.self] }
        set { self[FoodClient.self] = newValue }
    }
}


