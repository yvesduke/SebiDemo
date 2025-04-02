//
//  APIService.swift
//  DrSebi
//
//  Created by Yves Dukuze on 01/04/2025.
//

import Foundation
import RxSwift

protocol APIServiceProtocol {
    func fetchHerbs() -> Single<[Herb]>
    func fetchFoods() -> Single<[Food]>
}

final class APIService: APIServiceProtocol {
    
    // MARK: - URL Constants
    private enum API {
        static let baseURL = "https://62bc4a356b1401736cf7083b.mockapi.io"
        
        enum Endpoints {
            static let herbs = baseURL + "/herbs"
            static let foods = "https://failingApi/foods" // Note: This is deliberately failing in the original code
        }
    }
    
    static let shared = APIService()
    
    private init() {}
    
    
    func fetchHerbs() -> Single<[Herb]> {
        Single.create { single in
            guard let url = URL(string: API.Endpoints.herbs) else {
                single(.failure(NetworkError.invalidURL))
                return Disposables.create()
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    single(.failure(NetworkError.unknown(error)))
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    single(.failure(NetworkError.noData))
                    return
                }
                guard (200...299).contains(httpResponse.statusCode) else {
                    single(.failure(NetworkError.serverError(httpResponse.statusCode)))
                    return
                }
                guard let data = data else {
                    single(.failure(NetworkError.noData))
                    return
                }
                
                do {
                    let herbs = try JSONDecoder().decode([Herb].self, from: data)
                    single(.success(herbs))
                } catch {
                    single(.failure(NetworkError.decodingError))
                }
            }
            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    func fetchFoods() -> Single<[Food]> {
        Single.create { single in
            guard let url = URL(string: API.Endpoints.foods) else {
                single(.failure(NetworkError.invalidURL))
                return Disposables.create()
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    single(.failure(NetworkError.unknown(error)))
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    single(.failure(NetworkError.noData))
                    return
                }
                guard (200...299).contains(httpResponse.statusCode) else {
                    single(.failure(NetworkError.serverError(httpResponse.statusCode)))
                    return
                }
                guard let data = data else {
                    single(.failure(NetworkError.noData))
                    return
                }
                
                do {
                    let foods = try JSONDecoder().decode([Food].self, from: data)
                    single(.success(foods))
                } catch {
                    single(.failure(NetworkError.decodingError))
                }
            }
            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }
    }
}

