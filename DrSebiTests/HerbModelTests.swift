import XCTest
@testable import DrSebi

final class HerbModelTests: XCTestCase {
    
    func testHerbInitialization() {
        let herb = Herb(id: "123", name: "Burdock Root", Description: "A powerful detoxifier", avatar: "burdock.jpg")
        XCTAssertEqual(herb.id, "123")
        XCTAssertEqual(herb.name, "Burdock Root")
        XCTAssertEqual(herb.Description, "A powerful detoxifier")
        XCTAssertEqual(herb.avatar, "burdock.jpg")
    }
    
    func testHerbEquality() {
        let herb1 = Herb(id: "1", name: "Burdock Root", Description: "A powerful detoxifier", avatar: "burdock.jpg")
        let herb2 = Herb(id: "1", name: "Burdock Root", Description: "A powerful detoxifier", avatar: "burdock.jpg")
        let herb3 = Herb(id: "2", name: "Dandelion", Description: "Liver cleanser", avatar: "dandelion.jpg")
        let herb4 = Herb(id: "1", name: "Burdock Root", Description: "Different description", avatar: "burdock.jpg")
        
        XCTAssertEqual(herb1, herb2)
        XCTAssertNotEqual(herb1, herb3)
        XCTAssertEqual(herb1, herb4, "Herbs with same ID and name but different descriptions should be equal")
    }
    
    func testHerbDecodable() throws {
        let json = """
        {
            "id": "42",
            "name": "Chaparral",
            "Description": "Powerful antioxidant",
            "avatar": "chaparral.jpg"
        }
        """.data(using: .utf8)!
        
        let herb = try JSONDecoder().decode(Herb.self, from: json)
        XCTAssertEqual(herb.id, "42")
        XCTAssertEqual(herb.name, "Chaparral")
        XCTAssertEqual(herb.Description, "Powerful antioxidant")
        XCTAssertEqual(herb.avatar, "chaparral.jpg")
    }
    
    func testInvalidHerbDecoding() {
        let invalidJson = """
        {
            "id": "42",
            "name": "Chaparral"
        }
        """.data(using: .utf8)!
        
        XCTAssertThrowsError(try JSONDecoder().decode(Herb.self, from: invalidJson), "Decoding should fail when required fields are missing")
    }
} 