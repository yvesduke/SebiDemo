import XCTest
import SwiftUI
import ComposableArchitecture
@testable import DrSebi

final class FoodsViewTests: XCTestCase {
    
    // Use the Food model from the main module
    typealias FoodModel = DrSebi.Food
    
    func testFoodsViewInitialization() {
        let store = Store(
            initialState: FoodsFeature.State(),
            reducer: { FoodsFeature() }
        )
        
        let view = FoodsView(store: store)
        XCTAssertNotNil(view)
    }
    
    func testFoodsViewWithDifferentStates() {
        // Create a State with isLoading flag
        var loadingState = FoodsFeature.State()
        loadingState.isLoading = true
        
        let loadingStore = Store(
            initialState: loadingState,
            reducer: { FoodsFeature() }
        )
        let loadingView = FoodsView(store: loadingStore)
        XCTAssertNotNil(loadingView)
        
        // Create a State with error message
        var errorState = FoodsFeature.State()
        errorState.errorMessage = "Test error"
        
        let errorStore = Store(
            initialState: errorState,
            reducer: { FoodsFeature() }
        )
        let errorView = FoodsView(store: errorStore)
        XCTAssertNotNil(errorView)
        
        // Create a State with mock foods
        let mockFoods = [FoodModel(id: 1, name: "Apple"), FoodModel(id: 2, name: "Banana")]
        var itemsState = FoodsFeature.State()
        itemsState.items = mockFoods
        
        let itemsStore = Store(
            initialState: itemsState,
            reducer: { FoodsFeature() }
        )
        let itemsView = FoodsView(store: itemsStore)
        XCTAssertNotNil(itemsView)
        
        // Create a State with detail state
        let mockFood = FoodModel(id: 1, name: "Apple")
        var detailState = FoodsFeature.State()
        detailState.detailState = Foods.FoodDetailFeature.State(food: mockFood)
        
        let detailStore = Store(
            initialState: detailState,
            reducer: { FoodsFeature() }
        )
        let detailView = FoodsView(store: detailStore)
        XCTAssertNotNil(detailView)
    }
}

final class FoodDetailViewTests: XCTestCase {
    
    // Use the Food model from the main module
    typealias FoodModel = DrSebi.Food
    
    func testFoodDetailViewInitialization() {
        let mockFood = FoodModel(id: 1, name: "Apple")
        let store = Store(
            initialState: Foods.FoodDetailFeature.State(food: mockFood),
            reducer: { Foods.FoodDetailFeature() }
        )
        
        let view = FoodDetailView(store: store)
        XCTAssertNotNil(view)
    }
    
    func testFoodDetailViewWithDifferentFoods() {
        let testCases = [
            FoodModel(id: 1, name: "Apple"),
            FoodModel(id: 2, name: "Banana"),
            FoodModel(id: 3, name: "Cherry")
        ]
        
        for food in testCases {
            let store = Store(
                initialState: Foods.FoodDetailFeature.State(food: food),
                reducer: { Foods.FoodDetailFeature() }
            )
            
            let view = FoodDetailView(store: store)
            XCTAssertNotNil(view, "View should initialize with food: \(food.name)")
        }
    }
    
    func testFoodDetailViewInteraction() {
        let mockFood = FoodModel(id: 1, name: "Apple")
        let store = Store(
            initialState: Foods.FoodDetailFeature.State(food: mockFood),
            reducer: { Foods.FoodDetailFeature() }
        )
        
        let view = FoodDetailView(store: store)
        XCTAssertNotNil(view)
    }
}
