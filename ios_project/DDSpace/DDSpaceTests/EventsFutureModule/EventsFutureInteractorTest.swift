//
//  EventsFutureInteractorTest.swift
//  DDSpaceTests
//
//  Created by Даниил Ярмоленко on 11.01.2023.
//

import XCTest
@testable import DDSpace
final class EventsFutureInteractorTest: XCTestCase {
    
    var presenter: TestInteractorEventsFuturePresenter!
    var interactor: EventsFutureInteractor!
    
    override func setUp() {
        super.setUp()
        interactor = EventsFutureInteractor()
        presenter = TestInteractorEventsFuturePresenter(interactor: interactor)
        interactor.output = presenter
    }
    func testLoadEvents() {
        XCTAssertEqual(presenter.events.count, 0, "Events count should be 0")
        presenter.loadData()
        presenter.expectation = self.expectation(description: "async request")
        
        waitForExpectations(timeout: 5) { (error) in
                if let error = error{
                    XCTFail("waiting with error: \(error.localizedDescription)")
                }
            }
    }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

extension EventsFutureInteractorTest {
    class TestInteractorEventsFuturePresenter: EventsFutureViewOutput, EventsFutureInteractorOutput {
        var events = [EventModel]()
        var expectation:XCTestExpectation?
        private let interactor: EventsFutureInteractor
        init(interactor: EventsFutureInteractor) {
            self.interactor = interactor
        }
        
        func getCountCell() -> Int {
            events.count
        }
        
        func getCell(index: Int) -> DDSpace.EventModel {
            if index < events.count {
                return events[index]
            } else {
                return EventModel(authorName: "", nameEvent: "", description: "", photos: [], dateStart: "", dateEnd: "", eventType: .standard)
            }
        }
        
        func clickOnEvent(with id: Int) {
            //router
        }
        
        func receiveData(events: [DDSpace.EventModel]) {
            self.events = events
            XCTAssert(!events.isEmpty)
            expectation?.fulfill()
        }
        func loadData() {
            interactor.loadFutureEvents()
        }
    }
}
