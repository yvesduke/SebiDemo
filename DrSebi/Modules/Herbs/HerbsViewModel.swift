//
//  HerbsViewModel.swift
//  DrSebi
//
//  Created by Yves Dukuze on 01/04/2025.
//

import Foundation
import RxSwift
import RxCocoa

struct HerbItem {
    let name: String
    let benefits: String
}

class HerbsViewModel {
    private let _herbs = BehaviorRelay<[HerbItem]>(value: [])
    
    var herbs: Observable<[HerbItem]> {
        return _herbs.asObservable()
    }
    
    init() {
        loadInitialData()
    }
    
    private func loadInitialData() {
        let initialHerbs = [
            HerbItem(name: "Burdock Root", benefits: "Blood purifier, liver support"),
            HerbItem(name: "Dandelion", benefits: "Liver cleanse, digestive aid"),
            HerbItem(name: "Yellow Dock", benefits: "Iron-rich, blood builder"),
            HerbItem(name: "Sarsaparilla", benefits: "Anti-inflammatory, skin health"),
            HerbItem(name: "Red Clover", benefits: "Blood cleanser, respiratory support"),
            HerbItem(name: "Chaparral", benefits: "Antioxidant, antimicrobial"),
            HerbItem(name: "Cayenne", benefits: "Circulation, heart health"),
            HerbItem(name: "Mullein", benefits: "Respiratory support, lung health")
        ]
        
        _herbs.accept(initialHerbs)
    }
}

