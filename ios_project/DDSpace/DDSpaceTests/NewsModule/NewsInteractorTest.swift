//
//  NewsInteractorTest.swift
//  DDSpaceTests
//
//  Created by Даниил Ярмоленко on 11.01.2023.
//

import XCTest
@testable import DDSpace

final class NewsInteractorTest: XCTestCase {
    
    var presenter: TestInteractorNewsPresenter!
    var interactor: NewsInteractor!
    
    
    override func setUp() {
        super.setUp()
        interactor = NewsInteractor()
        presenter = TestInteractorNewsPresenter(interactor: interactor)
        interactor.output = presenter
    }
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadNews() {
        XCTAssertEqual(presenter.news.count, 0, "News count should be 0")
        presenter.viewDidLoad()
        presenter.expectation = self.expectation(description: "async request")
        
        waitForExpectations(timeout: 5) { (error) in
                if let error = error{
                    XCTFail("waiting with error: \(error.localizedDescription)")
                }
            }
    }
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

extension NewsInteractorTest {
    class TestInteractorNewsPresenter: NewsInteractorOutput, NewsViewOutput {
        var news = [NewsModel]()
        var expectation:XCTestExpectation?
        private let interactor: NewsInteractorInput
    
        init(interactor: NewsInteractorInput) {
            self.interactor = interactor
        }
        func receiveData(news: [DDSpace.NewsModel]) {
            self.news = news
            XCTAssertEqual(news.count, 3, "News count should be 3")
            expectation?.fulfill()
        }
        
        func viewDidLoad(){
            interactor.loadNews()
        }
        
        func clickOnNews(with id: Int) {
//
        }
        
        func getCountNewsCells() -> Int {
            news.count
        }
        
        func getNewsCell(with index: Int) -> DDSpace.NewsModel {
            news[index]
        }
        
        
    }
}
