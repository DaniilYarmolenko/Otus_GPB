//
//  FoodDetailPresenterTest.swift
//  DDArtTests
//
//  Created by Даниил Ярмоленко on 05.12.2022.
//

import XCTest
@testable import DDSpace

final class FoodDetailPresenterTest: XCTestCase {
    
    var testState: Bool = false
    let food = FoodModel(id: UUID(), nameFood: "first", description: "firstDesc", photos: [], cost: 200)
    var presenter: FoodDetailPresenter!
    var interactor: TestFoodDetailInteractor!
    var router: TestFoodDetailRouter!
    
    override func setUp() {
        super.setUp()
        interactor = TestFoodDetailInteractor()
        router = TestFoodDetailRouter()
        presenter = FoodDetailPresenter(router: router, interactor: interactor)
        presenter.food = food
        interactor.output = presenter
    }
    func testAddToCoreData() {
        presenter.addToCoreData(image: Data())
        let count = presenter.getFoodCountInCart()
        XCTAssertEqual(count, 1, "Food count in Cart should be 1")
    }
    func testChangeCountAndDeleteFood() {
        CoreDataService.shared.deleteAll()
        var count = presenter.getFoodCountInCart()
        XCTAssertEqual(count, 0, "Food count in Cart should be 0") // Delete All
        presenter.addToCoreData(image: Data())
        count = presenter.getFoodCountInCart()
        XCTAssertEqual(count, 1, "Food count in Cart should be 1")
        XCTAssert(CoreDataService.shared.isContain(with: "\(food.id ?? UUID())"))
        
        presenter.updateFood(image: Data(), value: 4)
        count = presenter.getFoodCountInCart()
        XCTAssertEqual(count, 4, "Food count in Cart should be 4")
        
        presenter.deleteFromCoreData()
        count = presenter.getFoodCountInCart()
        XCTAssertEqual(count, 0, "Food count in Cart should be 0")
    }
    func testGoToCart() {
        XCTAssert(!router.state)
        presenter.goToCart()
        XCTAssert(router.state)
    }
    
}
extension FoodDetailPresenterTest {
    class TestFoodDetailRouter: FoodDetailRouterInput {
        var state = false
        func goToCart(with view: DDSpace.FoodDetailViewInput?) {
            state.toggle()
        }
    }
    
    
    class TestFoodDetailInteractor: FoodDetailInteractorInput {
        func getFoodCountInCart(id: String) -> Int {
            CoreDataService.shared.fetchCountCart(with: id)
        }
        
        func updateFood(food: DDSpace.FoodSaveModel) {
            CoreDataService.shared.update(with: food)
        }
        
        func addToCoreData(food: DDSpace.FoodSaveModel) {
            CoreDataService.shared.insert(with: food)
        }
        
        func deleteFromCoreData(id: String) {
            CoreDataService.shared.delete(with: id)
        }
        
        weak var output: FoodDetailInteractorOutput?
    }
}

