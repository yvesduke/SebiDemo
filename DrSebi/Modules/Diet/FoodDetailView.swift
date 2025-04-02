//
//  FoodDetailView.swift
//  DrSebi
//
//  Created by Yves Dukuze on 01/04/2025.
//

import SwiftUI
import ComposableArchitecture

public struct FoodDetailView: View {
    let store: StoreOf<Foods.FoodDetailFeature>
    
    public init(store: StoreOf<Foods.FoodDetailFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                Text("Detail for: \(viewStore.food.name)")
                    .font(.headline)
                    .padding()
                
                Spacer()
            }
            .navigationBarTitle(viewStore.food.name)
            .onDisappear {
                viewStore.send(.onDisappear)
            }
        }
    }
}
