//
//  FoodsEnvironment.swift
//  DrSebi
//
//  Created by Yves Dukuze on 18/10/2023.
//

import RxSwift
import ComposableArchitecture

public class LiveFoodClient {
    public init() {}
    
    let disposeBag = DisposeBag()

    public func fetchFoods() async throws -> [Food] {
        try await withCheckedThrowingContinuation { continuation in
            APIService.shared.fetchFoods()
                .subscribe { event in
                    switch event {
                    case .success(let items):
                        continuation.resume(returning: items)
                    case .failure(let error):
                        if let netErr = error as? NetworkError {
                            continuation.resume(throwing: netErr)
                        } else {
                            continuation.resume(throwing: NetworkError.unknownMessage(error.localizedDescription))
                        }
                    }
                }
                .disposed(by: disposeBag)
        }
    }
}


