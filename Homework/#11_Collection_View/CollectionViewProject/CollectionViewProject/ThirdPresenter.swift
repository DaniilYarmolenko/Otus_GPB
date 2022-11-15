import Foundation

class ThirdPresenter {
        // MARK: - VIPER Stack
        weak var interactor: ThirdPresenterToInteractorInterface!
        weak var view: ThirdPresenterToViewInterface!
        weak var wireframe: ThirdPresenterToWireframeInterface!

        // MARK: - Instance Variables
        weak var delegate: ThirdDelegate?
        var moduleWireframe: Third {
                get {
                        let mw = (self.wireframe as? Third)!
                        return mw
                }
        }

        // MARK: - Operational

}

// MARK: - Interactor to Presenter Interface
extension ThirdPresenter: ThirdInteractorToPresenterInterface {

}

// MARK: - View to Presenter Interface
extension ThirdPresenter: ThirdViewToPresenterInterface {

}

// MARK: - Wireframe to Presenter Interface
extension ThirdPresenter: ThirdWireframeToPresenterInterface {
        func set(delegate newDelegate: ThirdDelegate?) {
                delegate = newDelegate
        }
}

// MARK: - Communication Interfaces
// VIPER Interface to the Module
protocol ThirdDelegate: AnyObject {

}

// VIPER Interface for communication from Presenter to Interactor
protocol ThirdPresenterToInteractorInterface: AnyObject {

}

// VIPER Interface for communication from Presenter -> Wireframe
protocol ThirdPresenterToWireframeInterface: AnyObject {

}

// VIPER Interface for communication from Presenter -> View
protocol ThirdPresenterToViewInterface: AnyObject {

}
