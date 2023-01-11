//
//  FoodDetailInteractorTest.swift
//  DDSpaceTests
//
//  Created by Даниил Ярмоленко on 11.01.2023.
//

import XCTest
@testable import DDSpace

final class FoodDetailInteractorTest: XCTestCase {
    
    var presenter: TestInteractorFoodDetailPresenter!
    var interactor: FoodDetailInteractor!
    
    override func setUp() {
        super.setUp()
        interactor = FoodDetailInteractor()
        presenter = TestInteractorFoodDetailPresenter(interactor: interactor)
        interactor.output = presenter
    }
    
    func testAddAndDeleteInCoreData() {
        presenter.food = FoodModel(id: UUID(), nameFood: "first", description: "firstTest", photos: [], cost: 1)
        CoreDataService.shared.deleteAll()
        var countItemsInCD: Int = CoreDataService.shared.fetchAll().count
        XCTAssertEqual(countItemsInCD, 0, "Items count in Core Data should be 0")
        presenter.addToCoreData(image: Data())
        countItemsInCD = CoreDataService.shared.fetchAll().count
        XCTAssertEqual(countItemsInCD, 1, "Items count in Core Data should be 1")
        presenter.deleteFromCoreData()
        countItemsInCD = CoreDataService.shared.fetchAll().count
        XCTAssertEqual(countItemsInCD, 0, "Items count in Core Data should be 0 ")
    }
    
    func testUpdateCoreDataCount() {
        presenter.food = FoodModel(id: UUID(), nameFood: "first", description: "firstTest", photos: [], cost: 1)
        let countItemsInCD: Int = CoreDataService.shared.fetchAll().count
        XCTAssertEqual(countItemsInCD, 0, "Items count in Core Data should be 0")
        presenter.addToCoreData(image: Data())
        var foodCountInCoreData = presenter.getFoodCountInCart()
        XCTAssertEqual(foodCountInCoreData, 1, "Items count in Core Data should be 1")
        presenter.updateFood(image: Data(), value: 3)
        foodCountInCoreData = presenter.getFoodCountInCart()
        XCTAssertEqual(foodCountInCoreData, 3, "Items count in Core Data should be 3")
        
    }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
}

extension FoodDetailInteractorTest {
    class TestInteractorFoodDetailPresenter: FoodDetailViewOutput, FoodDetailInteractorOutput {
        private let interactor: FoodDetailInteractorInput
        var food: FoodModel?
        
        init(interactor: FoodDetailInteractorInput) {
            self.interactor = interactor
        }
        func viewDidLoad() {
        }
        
        func getFoodCountInCart() -> Int {
            interactor.getFoodCountInCart(id: "\(food?.id ?? UUID())")
        }
        
        func addToCoreData(image: Data) {
            let food = FoodSaveModel(
                id: "\(food?.id ?? UUID())",
                nameFood: food?.nameFood ?? "",
                data: image,
                count: 1,
                cost: food?.cost ?? 0)
            interactor.addToCoreData(food: food)
        }
        
        func deleteFromCoreData() {
            interactor.deleteFromCoreData(id: "\(food?.id ?? UUID())")
        }
        
        func updateFood(image: Data, value: Int) {
            let food = FoodSaveModel(
                id: "\(food?.id ?? UUID())",
                nameFood: food?.nameFood ?? "",
                data: image,
                count: value,
                cost: food?.cost ?? 0)
            interactor.updateFood(food: food)
        }
        
        func goToCart() {
            
        }
        
        func getTitle() -> String {
            food?.nameFood ?? ""
        }
        
        
        
    }
}
