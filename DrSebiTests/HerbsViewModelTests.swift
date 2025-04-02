import XCTest
import RxSwift
import RxTest
import RxBlocking
@testable import DrSebi

final class HerbsViewModelTests: XCTestCase {
    
    private var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        disposeBag = nil
        super.tearDown()
    }
    
    func testInitialDataLoading() {
        let viewModel = HerbsViewModel()
        
        do {
            let herbs = try viewModel.herbs.toBlocking(timeout: 1.0).first()
            XCTAssertNotNil(herbs)
            XCTAssertFalse(herbs!.isEmpty, "Initial herbs should not be empty")
            
            XCTAssertEqual(herbs!.count, 8, "Should have 8 herbs by default")
            
            let firstHerb = herbs!.first!
            XCTAssertEqual(firstHerb.name, "Burdock Root")
            XCTAssertEqual(firstHerb.benefits, "Blood purifier, liver support")
        } catch {
            XCTFail("Failed to get herbs from observable: \(error)")
        }
    }
    
    func testHerbItemCreation() {
        let herbItem = HerbItem(name: "Test Herb", benefits: "Test Benefits")
        
        XCTAssertEqual(herbItem.name, "Test Herb")
        XCTAssertEqual(herbItem.benefits, "Test Benefits")
    }
    
    func testHerbsObservableEmission() {
        let scheduler = TestScheduler(initialClock: 0)
        let viewModel = HerbsViewModel()
        
        let observer = scheduler.createObserver([HerbItem].self)
        
        viewModel.herbs
            .subscribe(observer)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(observer.events.count, 1, "Should emit initial herbs")
        
        if let herbs = observer.events.first?.value.element {
            XCTAssertEqual(herbs.count, 8, "Should emit 8 herbs")
            
            XCTAssertTrue(herbs.contains(where: { $0.name == "Burdock Root" }))
            XCTAssertTrue(herbs.contains(where: { $0.name == "Dandelion" }))
            XCTAssertTrue(herbs.contains(where: { $0.name == "Cayenne" }))
        } else {
            XCTFail("No emission or emission was an error")
        }
    }
} 
