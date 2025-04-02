import ComposableArchitecture
import Foundation

// Add a namespace for the Foods module
extension DrSebi.Modules.Features.Foods {
    @Reducer
    struct FoodDetailFeature {
        // MARK: - Child State
        struct State: Equatable {
            var food: Food
            
            init(food: Food) {
                self.food = food
            }
        }
        
        // MARK: - Child Actions
        enum Action: Equatable {
            case onDisappear
        }
        
        // MARK: - Reducer
        var body: some ReducerOf<Self> {
            Reduce { state, action in
                switch action {
                case .onDisappear:
                    // Let parent know detail is closing
                    return .none
                }
            }
        }
    }
} 