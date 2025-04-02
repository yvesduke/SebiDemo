import Foundation
import ComposableArchitecture

// Add a namespace for the Foods module
extension DrSebi.Modules.Features.Foods {
    struct Food: Equatable, Identifiable {
        let id: UUID
        let name: String
        let category: String
        let description: String
    }

    @Reducer
    struct FoodsFeature {
        // MARK: - Parent State
        struct State: Equatable {
            var items: [Food] = []
            var isLoading: Bool = false
            var errorMessage: String?
            
            // If not nil, we're showing detail
            var detailState: FoodDetailFeature.State?
            
            init() {}
        }
        
        // MARK: - Parent Action
        enum Action: Equatable {
            // Fetching
            case fetchFoods
            case foodsResponse(TaskResult<[Food]>)  // TCA 1.x type for async results
            
            // User taps an item
            case didSelectItem(Food)
            
            // Child actions
            case detail(FoodDetailFeature.Action)
        }
        
        // MARK: - Dependencies
        @Dependency(\.foodClient) var foodClient
        
        // MARK: - Reducer
        var body: some ReducerOf<Self> {
            Reduce { state, action in
                switch action {
                    
                case .fetchFoods:
                    state.isLoading = true
                    state.errorMessage = nil
                    // Start an async task
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
                    // Create detail child state to navigate
                    state.detailState = FoodDetailFeature.State(food: food)
                    return .none
                    
                case .detail(.onDisappear):
                    // Reset detail state
                    state.detailState = nil
                    return .none
                    
                case .detail:
                    return .none
                }
            }
            // Combine with child reducer
            .ifLet(\.detailState, action: /Action.detail) {
                FoodDetailFeature()
            }
        }
    }
} 