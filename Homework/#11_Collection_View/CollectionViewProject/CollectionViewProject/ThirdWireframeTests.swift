import Nimble
import Quick

@testable import CollectionViewProject

 // swiftlint:disable:next type_body_length
class ThirdWireframeSpec: QuickSpec {
        // swiftlint:disable:next function_body_length
        override func spec() {
                var wireframe: ThirdWireframe!

                var presenterMock: ThirdWireframeToPresenterInterfaceMock!
                var viewMock: ThirdNavigationInterfaceMock!

                describe("a Third wireframe") {
                        beforeEach {
                                wireframe = ThirdWireframe()
                                presenterMock = ThirdWireframeToPresenterInterfaceMock()
                                viewMock = ThirdNavigationInterfaceMock()

                                wireframe.presenter = presenterMock
                                wireframe.view = viewMock
                        }

                        // MARK: - Init
                        describe("init function") {
                                it("instantiates and connect the VIPER stack") {
                                        // Arrange
                                        wireframe = ThirdWireframe()

                                        // Act

                                        // Assert
                                        expect(wireframe).toNot(beNil())
                                        expect(wireframe.moduleInteractor).toNot(beNil())
                                        expect(wireframe.modulePresenter).toNot(beNil())
                                        expect(wireframe.moduleView).toNot(beNil())

                                        expect(wireframe.moduleInteractor.presenter).to(beIdenticalTo(wireframe.modulePresenter))

                                        expect(wireframe.modulePresenter.interactor).to(beIdenticalTo(wireframe.moduleInteractor))
                                        expect(wireframe.modulePresenter.view).to(beIdenticalTo(wireframe.moduleView))
                                        expect(wireframe.modulePresenter.wireframe).to(beIdenticalTo(wireframe))

                                        expect(wireframe.moduleView.presenter).to(beIdenticalTo(wireframe.modulePresenter))

                                        expect(wireframe.presenter).to(beIdenticalTo(wireframe.modulePresenter))
                                        expect(wireframe.view).to(beIdenticalTo(wireframe.moduleView))
                                }
                        }

                        // MARK: - Class Functions
                        describe("storyboard class function") {
                                it("returns the storyboard with the Third storyboard identifier") {
                                        // Arrange
                                        let storyboard = ThirdWireframe.storyboard()

                                        // Act

                                        // Assert
                                        let storyboardName = storyboard.value(forKey: "name") as? String
                                        expect(storyboardName).toNot(beNil())
                                        expect(storyboardName).to(equal(ThirdConstants.storyboardIdentifier))
                                }
                        }

                        // MARK: - Operational
                        describe("get delegate function") {
                                it("should ask presenter for the module's delegate") {
                                        // Arrange

                                        // Act
                                        _ = wireframe.delegate

                                        // Assert
                                        expect(presenterMock.functionsCalled).to(contain("delegate"))
                                }
                        }

                        describe("set delegate function") {
                                it("tells presenter to set the module delegate") {
                                        // Arrange
                                        let delegateMock = ThirdDelegateMock()

                                        // Act
                                        wireframe.delegate = delegateMock

                                        // Assert
                                        expect(presenterMock.functionsCalled).to(contain("set(delegate:)"))
                                        expect(presenterMock.modifiedDelegate).to(beIdenticalTo(delegateMock))
                                }
                        }

                        // MARK: - Module Interface

                        // MARK: - Presenter to Wireframe Interface
                }
        }
}

// MARK: - Communicaiton Interface Mocks
// MARK: - Wireframe to Presenter
class ThirdWireframeToPresenterInterfaceMock {
        var functionsCalled = [String]()

        // MARK: - Input Variables
        var modifiedDelegate: ThirdDelegate?

        // MARK: - Output Variables
        var delegateToReturn: ThirdDelegate?
}

extension ThirdWireframeToPresenterInterfaceMock: ThirdWireframeToPresenterInterface {
        weak var delegate: ThirdDelegate? {
                get {
                        functionsCalled.append(#function)
                        return delegateToReturn
                }
        }

        func set(delegate newDelegate: ThirdDelegate?) {
                functionsCalled.append(#function)
                modifiedDelegate = newDelegate
        }
}

// swiftlint:disable:this file_length
