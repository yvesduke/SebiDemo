import XCTest
@testable import DrSebi

final class FoodModelTests: XCTestCase {
    
    // Explicitly specify that we're testing the Food from the Models directory
    typealias FoodModel = DrSebi.Food
    
    func testFoodInitialization() {
        let food = FoodModel(id: 123, name: "Avocado")
        XCTAssertEqual(food.id, 123)
        XCTAssertEqual(food.name, "Avocado")
    }
    
    func testFoodEquality() {
        let food1 = FoodModel(id: 1, name: "Apple")
        let food2 = FoodModel(id: 1, name: "Apple")
        let food3 = FoodModel(id: 2, name: "Banana")
        let food4 = FoodModel(id: 1, name: "Banana")
        
        XCTAssertEqual(food1, food2)
        XCTAssertNotEqual(food1, food3)
        XCTAssertNotEqual(food1, food4)
    }
    
    func testFoodDecodable() throws {
        let json = """
        {
            "id": 42,
            "name": "Mango"
        }
        """.data(using: .utf8)!
        
        let food = try JSONDecoder().decode(FoodModel.self, from: json)
        XCTAssertEqual(food.id, 42)
        XCTAssertEqual(food.name, "Mango")
    }
    
    func testFoodEncodable() throws {
        let food = FoodModel(id: 99, name: "Papaya")
        let data = try JSONEncoder().encode(food)
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        XCTAssertEqual(jsonObject?["id"] as? Int, 99)
        XCTAssertEqual(jsonObject?["name"] as? String, "Papaya")
    }
} 