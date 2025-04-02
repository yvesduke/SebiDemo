import XCTest
import RxSwift
import RxCocoa
@testable import DrSebi

final class HerbsViewControllerTests: XCTestCase {
    
    var sut: HerbsViewController!
    
    override func setUp() {
        super.setUp()
        sut = HerbsViewController()
        _ = sut.view // Force view to load
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testViewControllerInitialization() {
        XCTAssertNotNil(sut)
        XCTAssertNotNil(sut.view)
    }
    
    func testViewSetup() {
        XCTAssertEqual(sut.view.backgroundColor, .systemBackground)
        
        XCTAssertEqual(sut.title, "Healing Herbs")
        
        let tableView = findTableViewInViewHierarchy(sut.view)
        XCTAssertNotNil(tableView, "TableView should be in the view hierarchy")
        
        if let tableView = tableView {

            let cell = tableView.dequeueReusableCell(withIdentifier: "HerbCell")
            XCTAssertNotNil(cell, "Cell with identifier 'HerbCell' should be registered")
            
            XCTAssertEqual(tableView.rowHeight, UITableView.automaticDimension)
            XCTAssertGreaterThan(tableView.estimatedRowHeight, 0)
            
            let constraints = sut.view.constraints + tableView.constraints
            let hasTopConstraint = constraints.contains { constraint in
                return constraint.firstItem === tableView && constraint.firstAttribute == .top
            }
            XCTAssertTrue(hasTopConstraint, "TableView should have a top constraint")
        }
    }
    
    
    func testTableViewDataSourceBinding() {

        let tableView = findTableViewInViewHierarchy(sut.view)
        XCTAssertNotNil(tableView)
        
        if let tableView = tableView {
            XCTAssertNotNil(tableView.dataSource, "TableView should have a data source set by RxCocoa")
            
            let expectation = XCTestExpectation(description: "Wait for table view to load data")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let numberOfRows = tableView.numberOfRows(inSection: 0)
                XCTAssertGreaterThan(numberOfRows, 0, "Table view should have rows after binding")
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 1.0)
        }
    }
        
    private func findTableViewInViewHierarchy(_ view: UIView) -> UITableView? {
        if let tableView = view as? UITableView {
            return tableView
        }
        
        for subview in view.subviews {
            if let tableView = findTableViewInViewHierarchy(subview) {
                return tableView
            }
        }
        
        return nil
    }
} 
