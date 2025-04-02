import SwiftUI
import ComposableArchitecture

// Add a namespace for the Foods module
extension DrSebi.Modules.Features.Foods {
    struct FoodDetailView: View {
        let store: StoreOf<FoodDetailFeature>
        
        init(store: StoreOf<FoodDetailFeature>) {
            self.store = store
        }
        
        var body: some View {
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                VStack {
                    Text("Detail for: \(viewStore.food.name)")
                        .font(.title2)
                        .padding()
                    
                    Spacer()
                }
                .navigationTitle(viewStore.food.name)
                .onDisappear {
                    viewStore.send(.onDisappear)
                }
            }
        }
    }
} 