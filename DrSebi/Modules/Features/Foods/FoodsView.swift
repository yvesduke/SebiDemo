import SwiftUI
import ComposableArchitecture

// Add a namespace for the Foods module
extension DrSebi.Modules.Features.Foods {
    struct FoodsView: View {
        let store: StoreOf<FoodsFeature>
        
        public init(store: StoreOf<FoodsFeature>) {
            self.store = store
        }
        
        var body: some View {
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                NavigationStack {
                    VStack {
                        // Show error if any
                        if let error = viewStore.errorMessage {
                            Text("Error: \(error)")
                                .foregroundColor(.red)
                        }
                        
                        // Show a loading spinner if needed
                        if viewStore.isLoading {
                            ProgressView("Loading...")
                                .padding()
                        }
                        
                        // List of items
                        List(viewStore.items, id: \.id) { food in
                            Button {
                                viewStore.send(.didSelectItem(food))
                            } label: {
                                Text(food.name)
                            }
                        }
                    }
                    .navigationTitle("Foods")
                    
                    // TCA 1.x style for navigation
                    .navigationDestination(
                        store: store.scope(
                            state: \.detailState,
                            action: FoodsFeature.Action.detail
                        )
                    ) { detailStore in
                        FoodDetailView(store: detailStore)
                    }
                    
                    .onAppear {
                        // Trigger fetch
                        viewStore.send(.fetchFoods)
                    }
                }
            }
        }
    }
} 
} 