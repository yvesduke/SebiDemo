//import XCTest
//import ComposableArchitecture
//@testable import DrSebi
//
//final class FoodsTests: XCTestCase {
//    
//    @MainActor
//    func testFoodsInitialState() async {
//        let state = FoodsFeature.State()
//        XCTAssertEqual(state.items, [])
//        XCTAssertFalse(state.isLoading)
//        XCTAssertNil(state.errorMessage)
//        XCTAssertNil(state.detailState)
//    }
//    
//    @MainActor
//    func testFoodsFetch() async {
//        let mockFoods = [
//            Food(id: 1, name: "Apple"),
//            Food(id: 2, name: "Banana")
//        ]
//        
//        let store = TestStore(
//            initialState: FoodsFeature.State(),
//            reducer: { FoodsFeature() }
//        )
//        
//        store.dependencies.foodClient.fetchFoods = {
//            return mockFoods
//        }
//        
//        await store.send(.fetchFoods) { state in
//            state.isLoading = true
//            state.errorMessage = nil
//        }
//        
//        await store.receive(.foodsResponse(.success(mockFoods))) { state in
//            state.isLoading = false
//            state.items = mockFoods
//        }
//    }
//    
//    @MainActor
//    func testFoodsFetchFailureWithNetworkError() async {
//        let mockError = NetworkError.serverError(500)
//        
//        let store = TestStore(
//            initialState: FoodsFeature.State(),
//            reducer: { FoodsFeature() }
//        )
//        
//        store.dependencies.foodClient.fetchFoods = {
//            throw mockError
//        }
//        
//        await store.send(.fetchFoods) { state in
//            state.isLoading = true
//            state.errorMessage = nil
//        }
//        
//        await store.receive(.foodsResponse(.failure(mockError))) { state in
//            state.isLoading = false
//            state.errorMessage = mockError.errorDescription
//        }
//    }
//    
//    @MainActor
//    func testFoodsFetchFailureWithGenericError() async {
//        struct GenericError: Error {
//            let message: String
//        }
//        
//        let genericError = GenericError(message: "Unknown error")
//        
//        let store = TestStore(
//            initialState: FoodsFeature.State(),
//            reducer: { FoodsFeature() }
//        )
//        
//        store.dependencies.foodClient.fetchFoods = {
//            throw genericError
//        }
//        
//        await store.send(.fetchFoods) { state in
//            state.isLoading = true
//            state.errorMessage = nil
//        }
//        
//        await store.receive(.foodsResponse(.failure(genericError))) { state in
//            state.isLoading = false
//            state.errorMessage = genericError.localizedDescription
//        }
//    }
//    
//    @MainActor
//    func testFoodsFetchWithEmptyResults() async {
//        let emptyFoods: [Food] = []
//        
//        let store = TestStore(
//            initialState: FoodsFeature.State(),
//            reducer: { FoodsFeature() }
//        )
//        
//        store.dependencies.foodClient.fetchFoods = {
//            return emptyFoods
//        }
//        
//        await store.send(.fetchFoods) { state in
//            state.isLoading = true
//            state.errorMessage = nil
//        }
//        
//        await store.receive(.foodsResponse(.success(emptyFoods))) { state in
//            state.isLoading = false
//            state.items = emptyFoods
//        }
//    }
//    
//    @MainActor
//    func testFoodSelection() async {
//        let mockFood = Food(id: 1, name: "Apple")
//        
//        let store = TestStore(
//            initialState: FoodsFeature.State(),
//            reducer: { FoodsFeature() }
//        )
//        
//        await store.send(.didSelectItem(mockFood)) { state in
//            state.detailState = Foods.FoodDetailFeature.State(food: mockFood)
//        }
//    }
//    
//    @MainActor
//    func testFoodDetailDismissal() async {
//        let mockFood = Food(id: 1, name: "Apple")
//        let initialState = FoodsFeature.State(
//            items: [],
//            isLoading: false,
//            errorMessage: nil,
//            detailState: Foods.FoodDetailFeature.State(food: mockFood)
//        )
//        
//        let store = TestStore(
//            initialState: initialState,
//            reducer: { FoodsFeature() }
//        )
//        
//        await store.send(.detail(.onDisappear)) { state in
//            state.detailState = nil
//        }
//    }
//    
//    @MainActor
//    func testDetailActionNotAffectingState() async {
//        let mockFood = Food(id: 1, name: "Apple")
//        let initialState = FoodsFeature.State(
//            items: [mockFood],
//            isLoading: false,
//            errorMessage: nil,
//            detailState: Foods.FoodDetailFeature.State(food: mockFood)
//        )
//        
//        let store = TestStore(
//            initialState: initialState,
//            reducer: { FoodsFeature() }
//        )
//        
//        await store.send(.detail(.onDisappear)) { state in
//            state.detailState = nil
//        }
//    }
//    
//    @MainActor
//    func testFoodSelectionWithExistingDetail() async {
//        let initialFood = Food(id: 1, name: "Apple")
//        let newFood = Food(id: 2, name: "Banana")
//        
//        let initialState = FoodsFeature.State(
//            items: [initialFood, newFood],
//            isLoading: false,
//            errorMessage: nil,
//            detailState: Foods.FoodDetailFeature.State(food: initialFood)
//        )
//        
//        let store = TestStore(
//            initialState: initialState,
//            reducer: { FoodsFeature() }
//        )
//        
//        await store.send(.didSelectItem(newFood)) { state in
//            state.detailState = Foods.FoodDetailFeature.State(food: newFood)
//        }
//    }
//}
//
//final class FoodDetailFeatureTests: XCTestCase {
//    
//    @MainActor
//    func testFoodDetailInitialState() async {
//        let mockFood = Food(id: 1, name: "Apple")
//        let state = Foods.FoodDetailFeature.State(food: mockFood)
//        
//        XCTAssertEqual(state.food.id, 1)
//        XCTAssertEqual(state.food.name, "Apple")
//    }
//    
//    @MainActor
//    func testFoodDetailOnDisappear() async {
//        let mockFood = Food(id: 1, name: "Apple")
//        
//        let store = TestStore(
//            initialState: Foods.FoodDetailFeature.State(food: mockFood),
//            reducer: { Foods.FoodDetailFeature() }
//        )
//        
//        await store.send(.onDisappear)
//    }
//    
//    @MainActor
//    func testFoodDetailWithComplexFood() async {
//        let complexFood = Food(
//            id: 42,
//            name: "Avocado",
//            description: "Nutrient-dense fruit with healthy fats",
//            imageUrl: "avocado.jpg",
//            category: "Fruits",
//            benefits: ["Heart health", "Weight management"],
//            nutritionalValue: ["Fat": "15g", "Protein": "2g", "Carbs": "9g"]
//        )
//        
//        let state = Foods.FoodDetailFeature.State(food: complexFood)
//        
//        XCTAssertEqual(state.food.id, 42)
//        XCTAssertEqual(state.food.name, "Avocado")
//        XCTAssertEqual(state.food.description, "Nutrient-dense fruit with healthy fats")
//        XCTAssertEqual(state.food.imageUrl, "avocado.jpg")
//        XCTAssertEqual(state.food.category, "Fruits")
//        XCTAssertEqual(state.food.benefits, ["Heart health", "Weight management"])
//        XCTAssertEqual(state.food.nutritionalValue, ["Fat": "15g", "Protein": "2g", "Carbs": "9g"])
//    }
//    
//    @MainActor
//    func testFoodDetailActionHandling() async {
//        let foodA = Food(id: 1, name: "Strawberry", category: "Berries")
//        let foodB = Food(id: 2, name: "Broccoli", category: "Vegetables")
//        
//        let storeA = TestStore(
//            initialState: Foods.FoodDetailFeature.State(food: foodA),
//            reducer: { Foods.FoodDetailFeature() }
//        )
//        
//        await storeA.send(.onDisappear)
//        
//        let storeB = TestStore(
//            initialState: Foods.FoodDetailFeature.State(food: foodB),
//            reducer: { Foods.FoodDetailFeature() }
//        )
//        
//        await storeB.send(.onDisappear)
//    }
//}
