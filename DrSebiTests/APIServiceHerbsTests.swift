import XCTest
import RxSwift
import RxTest
import RxBlocking
@testable import DrSebi

final class APIServiceHerbsTests: XCTestCase {
    
    private var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        disposeBag = nil
        super.tearDown()
    }
    
    func testFetchHerbsSuccess() {
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        
        let mockData = """
        [
            {
                "id": "1",
                "name": "Burdock Root",
                "Description": "Blood purifier and liver support",
                "avatar": "burdock.jpg"
            },
            {
                "id": "2",
                "name": "Dandelion",
                "Description": "Supports liver function and digestion",
                "avatar": "dandelion.jpg"
            }
        ]
        """.data(using: .utf8)!
        
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url, url.absoluteString.contains("herbs") else {
                throw NetworkError.invalidURL
            }
            
            let response = HTTPURLResponse(
                url: URL(string: "https://62bc4a356b1401736cf7083b.mockapi.io/herbs")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: ["Content-Type": "application/json"]
            )!
            
            return (response, mockData)
        }
        
        let session = URLSession(configuration: configuration)
        
        // Create mock implementation of APIServiceProtocol
        let apiService = MockAPIService(session: session)
        
        do {
            let herbs = try apiService.fetchHerbs().toBlocking().first()!
            
            XCTAssertEqual(herbs.count, 2)
            XCTAssertEqual(herbs[0].id, "1")
            XCTAssertEqual(herbs[0].name, "Burdock Root")
            XCTAssertEqual(herbs[1].id, "2")
            XCTAssertEqual(herbs[1].name, "Dandelion")
        } catch {
            XCTFail("Should not fail: \(error)")
        }
    }
    
    func testFetchHerbsServerError() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(
                url: URL(string: "https://62bc4a356b1401736cf7083b.mockapi.io/herbs")!,
                statusCode: 500,
                httpVersion: nil,
                headerFields: nil
            )!
            
            return (response, Data())
        }
        
        let session = URLSession(configuration: configuration)
        
        // Create mock implementation of APIServiceProtocol
        let apiService = MockAPIService(session: session)
        
        do {
            _ = try apiService.fetchHerbs().toBlocking().first()!
            XCTFail("Should have thrown an error")
        } catch let error as NetworkError {
            switch error {
            case .serverError(let statusCode):
                XCTAssertEqual(statusCode, 500)
            default:
                XCTFail("Expected server error with status code 500, got \(error)")
            }
        } catch {
            XCTFail("Expected NetworkError, got \(error)")
        }
    }
}

// Mock implementation of APIServiceProtocol
class MockAPIService: APIServiceProtocol {
    let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func fetchHerbs() -> Single<[Herb]> {
        Single.create { single in
            guard let url = URL(string: "https://62bc4a356b1401736cf7083b.mockapi.io/herbs") else {
                single(.failure(NetworkError.invalidURL))
                return Disposables.create()
            }
            
            let task = self.session.dataTask(with: url) { data, response, error in
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
        // This method isn't used in these tests, but we need to implement it to conform to APIServiceProtocol
        return Single.error(NetworkError.unknownMessage("Not implemented in mock"))
    }
}

class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            fatalError("Handler is unavailable.")
        }
        
        do {
            let (response, data) = try handler(request)
            
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {}
}
