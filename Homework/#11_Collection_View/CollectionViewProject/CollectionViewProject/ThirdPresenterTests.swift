import Nimble
import Quick

@testable import CollectionViewProject

 // swiftlint:disable:next type_body_length
class ThirdPresenterSpec: QuickSpec {
        // swiftlint:disable:next function_body_length
        override func spec() {
                var presenter: ThirdPresenter!

                var delegateMock: ThirdDelegateMock!
                var interactorMock: ThirdPresenterToInteractorInterfaceMock!
                var viewMock: ThirdPresenterToViewInterfaceMock!
                var wireframeMock: ThirdWireframeInterfacesMock!

                describe("a Third presenter") {
                        beforeEach {
                                presenter = ThirdPresenter()
                                delegateMock = ThirdDelegateMock()
                                interactorMock = ThirdPresenterToInteractorInterfaceMock()
                                viewMock = ThirdPresenterToViewInterfaceMock()
                                wireframeMock = ThirdWireframeInterfacesMock()

                                presenter.delegate = delegateMock
                                presenter.interactor = interactorMock
                                presenter.view = viewMock
                                presenter.wireframe = wireframeMock
                        }

                        // MARK: - Operational
                        describe("module wireframe computed variable") {
                                it("returns the wireframe as a Third object") {
                                        // Arrange

                                        // Act
                                        let moduleWireframe = presenter.moduleWireframe

                                        // Assert
                                        expect(moduleWireframe).to(beIdenticalTo(wireframeMock))
                                }
                        }

                        // MARK: - Interactor to Presenter Interface

                        // MARK: - View to Presenter Interface

                        // MARK: - Wireframe to Presenter Interface
                        describe("set delegate function") {
                                it("sets the input as the new delegate") {
                                        // Arrange
                                        presenter.delegate = nil
                                        let testDelegate = ThirdDelegateMock()

                                        // Act
                                        presenter.set(delegate: testDelegate)

                                        // Assert
                                        expect(presenter.delegate).to(beIdenticalTo(testDelegate))
                                }
                        }
                }
        }
}

// MARK: - Communicaiton Interface Mocks
// MARK: - Delegate
class ThirdDelegateMock {
        var functionsCalled = [String]()

        // MARK: - Input Variables
}

extension ThirdDelegateMock: ThirdDelegate {

}

// MARK: - Present to Interactor
class ThirdPresenterToInteractorInterfaceMock {
        var functionsCalled = [String]()

        // MARK: - Input Variables
}

extension ThirdPresenterToInteractorInterfaceMock: ThirdPresenterToInteractorInterface {

}

// MARK: - Present to View
class ThirdPresenterToViewInterfaceMock {
        var functionsCalled = [String]()

        // MARK: - Input Variables
}

extension ThirdPresenterToViewInterfaceMock: ThirdPresenterToViewInterface {

}

// MARK: - Present to Wireframe
class ThirdWireframeInterfacesMock {
        var functionsCalled = [String]()

        // MARK: - Input Variables
}

extension ThirdWireframeInterfacesMock: Third {
        var delegate: ThirdDelegate? {
                get {
                        functionsCalled.append(#function)
                        return nil
                }
            set {
                functionsCalled.append(#function)
            }
        }
}

extension ThirdWireframeInterfacesMock: ThirdPresenterToWireframeInterface {

}

// swiftlint:disable:this file_length
