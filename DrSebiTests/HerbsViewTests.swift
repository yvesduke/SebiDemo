import XCTest
@testable import DrSebi

final class HerbsViewTests: XCTestCase {
    
    var sut: HerbsView!
    
    override func setUp() {
        super.setUp()
        sut = HerbsView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testViewInitialization() {
        XCTAssertNotNil(sut)
        
        XCTAssertEqual(sut.backgroundColor, .white)
    }
    
    func testTableViewSetup() {
        XCTAssertNotNil(sut.tableView)
        
        XCTAssertTrue(sut.subviews.contains(sut.tableView))
        
        let cell = sut.tableView.dequeueReusableCell(withIdentifier: "HerbCell")
        XCTAssertNotNil(cell, "Cell with identifier 'HerbCell' should be registered")
        
        XCTAssertFalse(sut.tableView.translatesAutoresizingMaskIntoConstraints)
    }
    
    func testConstraints() {

        sut.layoutIfNeeded()
        
        let tableViewConstraints = sut.constraints.filter { constraint in
            return constraint.firstItem === sut.tableView || constraint.secondItem === sut.tableView
        }
        XCTAssertGreaterThanOrEqual(tableViewConstraints.count, 4, "TableView should have at least 4 constraints")
        
        let hasTopConstraint = tableViewConstraints.contains { constraint in
            return constraint.firstAttribute == .top && constraint.secondAttribute == .top
        }
        
        let hasBottomConstraint = tableViewConstraints.contains { constraint in
            return constraint.firstAttribute == .bottom && constraint.secondAttribute == .bottom
        }
        
        let hasLeadingConstraint = tableViewConstraints.contains { constraint in
            return constraint.firstAttribute == .leading && constraint.secondAttribute == .leading
        }
        
        let hasTrailingConstraint = tableViewConstraints.contains { constraint in
            return constraint.firstAttribute == .trailing && constraint.secondAttribute == .trailing
        }
        
        XCTAssertTrue(hasTopConstraint, "TableView should have a top constraint")
        XCTAssertTrue(hasBottomConstraint, "TableView should have a bottom constraint")
        XCTAssertTrue(hasLeadingConstraint, "TableView should have a leading constraint")
        XCTAssertTrue(hasTrailingConstraint, "TableView should have a trailing constraint")
    }
    
    func testTableViewFrame() {
        sut.layoutIfNeeded()
        
        XCTAssertEqual(sut.tableView.frame.origin.x, 0)
        XCTAssertEqual(sut.tableView.frame.origin.y, 0)
        XCTAssertEqual(sut.tableView.frame.width, sut.frame.width)
        XCTAssertEqual(sut.tableView.frame.height, sut.frame.height)
    }
} 
