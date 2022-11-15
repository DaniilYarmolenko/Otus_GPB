import Nimble
import Quick

@testable import CollectionViewProject

 // swiftlint:disable:next type_body_length
class ThirdViewSpec: QuickSpec {
        // swiftlint:disable:next function_body_length
        override func spec() {
                var view: ThirdView!

                var presenterMock: ThirdViewToPresenterInterfaceMock!

                describe("a Third view") {
                        beforeEach {
                                view = ThirdView()
                                presenterMock = ThirdViewToPresenterInterfaceMock()

                                _ = view.view

                                view.presenter = presenterMock
                        }

                        // MARK: - Operational

                        // MARK: - Presenter to View Interface
                }
        }
}

// MARK: - Communicaiton Interface Mocks
// MARK: - Navigation
class ThirdNavigationInterfaceMock {
        var functionsCalled = [String]()

        // MARK: - Input Variables
}

extension ThirdNavigationInterfaceMock: ThirdNavigationInterface {

}

// MARK: - View to Presenter
class ThirdViewToPresenterInterfaceMock {
        var functionsCalled = [String]()

        // MARK: - Input Variables
}

extension ThirdViewToPresenterInterfaceMock: ThirdViewToPresenterInterface {

}

// swiftlint:disable:this file_length
