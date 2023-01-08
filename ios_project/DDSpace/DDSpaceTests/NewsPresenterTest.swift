//
//  NewsPresenterTest.swift
//  DDArtTests
//
//  Created by Даниил Ярмоленко on 08.01.2023.
//

import XCTest
@testable import DDArt

final class NewsPresenterTest: XCTestCase {
    
    var presenter: NewsPresenter!
    var interactor: TestNewsPresenterInteractor!
    var router: TestNewsPresenterRouter!

    override func setUp() {
        super.setUp()
        interactor = TestNewsPresenterInteractor()
        router = TestNewsPresenterRouter()
        presenter = NewsPresenter(router: router, interactor: interactor)
        interactor.output = presenter
    }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCountNews() throws {
        var count = presenter.getCountNewsCells()
        XCTAssertEqual(count, 0, "News count in Table should be 0")
        presenter.viewDidLoad()
        count = presenter.getCountNewsCells()
        XCTAssertEqual(count, 3, "News count in Table should be 0, but is \(presenter.getCountNewsCells())")
    }
    func testTouchOnNews() throws {
        presenter.viewDidLoad()
        var newsName = router.news?.newsName
        
        XCTAssertEqual(newsName, nil, "News count in Table should be nil, but is \(router.news?.newsName)")
//        Мы открылись и ждем гостей!
        presenter.clickOnNews(with: 0)
        newsName = router.news?.newsName
        XCTAssertEqual(newsName, "Мы открылись и ждем гостей!", "News count in Table should be, but is \(router.news?.newsName)")
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
extension NewsPresenterTest {
    class TestNewsPresenterRouter: NewsRouterInput {
        var news: NewsModel?
        func newsSelected(news: DDArt.NewsModel) {
            self.news = news
        }
    }
    
    
    class TestNewsPresenterInteractor: NewsInteractorInput {
        private var news = [NewsModel]()
        func loadNews() {
            guard let url = Bundle.main.url(forResource: "NewsMock", withExtension: "json") else {
                print("Errror")
                return
            }
            guard let data = try? Data(contentsOf: url, options: .mappedIfSafe) else {
                XCTFail("Fail get data from assets")
                return
            }
            do {
                let resources = try JSONDecoder().decode([NewsModel].self, from: data)
                news = resources
                output?.receiveData(news: news)
            } catch {
                XCTFail("Fail decoding Mock")
            }
        }
        weak var output: NewsInteractorOutput?
    }
}
