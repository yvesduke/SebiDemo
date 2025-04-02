//
//  DietViewModel.swift
//  DrSebi
//
//  Created by Yves Dukuze on 01/04/2025.
//

import UIKit
import SwiftUI
import ComposableArchitecture

public struct FoodsView: View {
    let store: StoreOf<FoodsFeature>
    
    public init(store: StoreOf<FoodsFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationView {
                VStack {
                    if let error = viewStore.errorMessage {
                        Text("Error: \(error)")
                            .foregroundColor(.red)
                    }
                    
                    if viewStore.isLoading {
                        Text("Loading...")
                            .padding()
                    }
                    
                    List(viewStore.items, id: \.id) { food in
                        Button(action: {
                            viewStore.send(.didSelectItem(food))
                        }) {
                            Text(food.name)
                        }
                    }
                }
                .navigationBarTitle("Foods")
                
                .sheet(
                    isPresented: .constant(viewStore.detailState != nil), 
                    onDismiss: { viewStore.send(.detail(.onDisappear)) }
                ) {
                    IfLetStore(
                        self.store.scope(
                            state: \.detailState,
                            action: FoodsFeature.Action.detail
                        )
                    ) { detailStore in
                        NavigationView {
                            FoodDetailView(store: detailStore)
                        }
                    }
                }
                
                .onAppear {
                    viewStore.send(.fetchFoods)
                }
            }
        }
    }
}

