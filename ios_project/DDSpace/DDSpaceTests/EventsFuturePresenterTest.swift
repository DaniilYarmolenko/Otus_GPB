//
//  EventsFuturePresenterTest.swift
//  DDArtTests
//
//  Created by Даниил Ярмоленко on 08.01.2023.
//

/**
 **Я здесь не проверяю на время, работаю со всеми мероприятиями, потому что непонятно, когда будете смотреть и мероприятия могут оказаться уже в прошлом)
 ***Я закоментировал код, который сортирет по дате*
 */

import XCTest
@testable import DDArt


final class EventsFuturePresenterTest: XCTestCase {

    var presenter: EventsFuturePresenter!
    var interactor: EventsFuturePresenterInteractor!
    var router: EventsFuturePresenterRouter!
    override func setUp() {
        super.setUp()
        interactor = EventsFuturePresenterInteractor()
        router = EventsFuturePresenterRouter()
        presenter = EventsFuturePresenter(router: router, interactor: interactor)
        interactor.output = presenter
    }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCountNews() throws {
        var count = presenter.getCountCell()
        XCTAssertEqual(count, 0, "News count in Table should be 0")
        presenter.loadData()
        count = presenter.getCountCell()
        XCTAssertEqual(count, 14, "News count in Table should be 14, but is \(presenter.getCountCell())")
    }
    func testTouchOnNews() throws {
        presenter.loadData()
        var nameEvent = router.event?.nameEvent
        
        XCTAssertEqual(nameEvent, nil, "News count in Table should be nil")
        presenter.clickOnEvent(with: 0)
        nameEvent = router.event?.nameEvent
        XCTAssertEqual(nameEvent, "Вечер шахмат", "News count in Table should be, but is \(router.event?.nameEvent)")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
extension EventsFuturePresenterTest {
    class EventsFuturePresenterRouter: EventsFutureRouterInput {
        var event: EventModel?
        
        func eventSelected(event: DDArt.EventModel) {
            self.event = event
        }
        
    }
    
    
    class EventsFuturePresenterInteractor: EventsFutureInteractorInput {
        var events = [EventModel]()
        func loadFutureEvents() {
//            let dateToday = Date().convertToTimeZone(initTimeZone: TimeZone(abbreviation: "MSD"))
            guard let url = Bundle.main.url(forResource: "EventMock", withExtension: "json") else {
                print("Errror")
                return
            }
            guard let data = try? Data(contentsOf: url, options: .mappedIfSafe) else {
                XCTFail("Fail get data from assets")
                return
            }
            do {
                let resources = try JSONDecoder().decode([EventModel].self, from: data)
                events = resources
//                let sortedEvents = events.filter ({ event in
//                    let dateEventEnd = event.dateEnd.toDate()
//                    return dateEventEnd > dateToday
//                })
                output?.receiveData(events: events)
            } catch {
                XCTFail("Fail decoding Mock")
            }
        }
        weak var output: EventsFutureInteractorOutput?
    }
}
