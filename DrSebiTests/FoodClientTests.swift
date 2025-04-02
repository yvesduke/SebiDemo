import XCTest
import RxSwift
import ComposableArchitecture
@testable import DrSebi

final class FoodClientTests: XCTestCase {
    
    func testFoodClientLiveValue() async {
        let client = FoodClient.liveValue
        
        XCTAssertNotNil(client)
        XCTAssertNoThrow(client.fetchFoods)
    }
    
    func testFoodClientTestValue() async {
        let client = FoodClient.testValue
        
        do {
            let foods = try await client.fetchFoods()
            XCTAssertEqual(foods.count, 1)
            XCTAssertEqual(foods.first?.id, 1)
            XCTAssertEqual(foods.first?.name, "Amaranth")
        } catch {
            XCTFail("Test value should not throw: \(error)")
        }
    }
    
    func testDependencyKeyConformance() {
        let values = DependencyValues()
        let client = values.foodClient
        
        XCTAssertNotNil(client)
    }
}

final class NetworkErrorTests: XCTestCase {
    
    func testNetworkErrorDescriptions() {
        XCTAssertEqual(NetworkError.invalidURL.errorDescription, "Invalid URL")
        XCTAssertEqual(NetworkError.noData.errorDescription, "No data received")
        XCTAssertEqual(NetworkError.decodingError.errorDescription, "Failed to decode response")
        XCTAssertEqual(NetworkError.serverError(404).errorDescription, "Server error with status code: 404")
        
        let error = NSError(domain: "test", code: 999, userInfo: [NSLocalizedDescriptionKey: "Test error"])
        XCTAssertEqual(NetworkError.unknown(error).errorDescription, "Test error")
        
        XCTAssertEqual(NetworkError.unknownMessage("Custom message").errorDescription, "Custom message")
    }
} 
