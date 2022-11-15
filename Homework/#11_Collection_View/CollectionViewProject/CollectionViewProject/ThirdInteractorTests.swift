import Nimble
import Quick

@testable import CollectionViewProject

 // swiftlint:disable:next type_body_length
class ThirdInteractorSpec: QuickSpec {
        // swiftlint:disable:next function_body_length
        override func spec() {
                var interactor: ThirdInteractor!

                var presenterMock: ThirdInteractorToPresenterInterfaceMock!

                describe("a Third interactor") {
                        beforeEach {
                                interactor = ThirdInteractor()
                                presenterMock = ThirdInteractorToPresenterInterfaceMock()

                                interactor.presenter = presenterMock
                        }

                        // MARK: - Operational

                        // MARK: - Presenter to Interactor Interface
                }
        }
}

// MARK: - Communicaiton Interface Mocks
// MARK: - Interactor to Presenter
class ThirdInteractorToPresenterInterfaceMock {
        var functionsCalled = [String]()

        // MARK: - Input Variables
}

extension ThirdInteractorToPresenterInterfaceMock: ThirdInteractorToPresenterInterface {

}

// swiftlint:disable:this file_length
