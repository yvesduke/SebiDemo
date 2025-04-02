//
//  FoodsFeature.swift
//  DrSebi
//
//  Created by Yves Dukuze on 01/04/2025.
//

import ComposableArchitecture
import Foundation

public struct Foods {
    public struct FoodDetailFeature: Reducer {
        public struct State: Equatable {
            public let food: Food
            
            public init(food: Food) {
                self.food = food
            }
        }
        
        public enum Action: Equatable {
            case onDisappear
        }
        
        public var body: some ReducerOf<Self> {
            Reduce { state, action in
                switch action {
                case .onDisappear:
                    return .none
                }
            }
        }
    }
}

public struct FoodsFeature: Reducer {
    
    public struct State: Equatable {
        public var items: [Food] = []
        public var isLoading: Bool = false
        public var errorMessage: String?
        
        public var detailState: Foods.FoodDetailFeature.State?
        
        public init() {}
    }
    
    public enum Action: Equatable {
        case fetchFoods
        case foodsResponse(TaskResult<[Food]>)
        
        case didSelectItem(Food)
        
        case detail(Foods.FoodDetailFeature.Action)
    }
    
    @Dependency(\.foodClient) var foodClient
    
    public init() {}
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case .fetchFoods:
                state.isLoading = true
                state.errorMessage = nil
                return .run { send in
                    do {
                        let foods = try await foodClient.fetchFoods()
                        await send(.foodsResponse(.success(foods)))
                    } catch {
                        await send(.foodsResponse(.failure(error)))
                    }
                }
                
            case let .foodsResponse(.success(foods)):
                state.isLoading = false
                state.items = foods
                return .none
                
            case let .foodsResponse(.failure(error)):
                state.isLoading = false
                if let networkErr = error as? NetworkError {
                    state.errorMessage = networkErr.errorDescription
                } else {
                    state.errorMessage = error.localizedDescription
                }
                return .none
                
            case let .didSelectItem(food):
                state.detailState = Foods.FoodDetailFeature.State(food: food)
                return .none
                
            case .detail(.onDisappear):
                state.detailState = nil
                return .none
                
            case .detail:
                return .none
            }
        }
        .ifLet(\.detailState, action: /Action.detail) {
            Foods.FoodDetailFeature()
        }
    }
}
