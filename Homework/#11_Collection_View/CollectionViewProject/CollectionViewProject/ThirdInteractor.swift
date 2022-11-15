import Foundation

class ThirdInteractor {
        // MARK: - VIPER Stack
        weak var presenter: ThirdInteractorToPresenterInterface!

        // MARK: - Instance Variables

        // MARK: - Operational

}

// MARK: - Presenter To Interactor Interface
extension ThirdInteractor: ThirdPresenterToInteractorInterface {

}

// MARK: - Communication Interfaces
// VIPER Interface for communication from Interactor -> Presenter
protocol ThirdInteractorToPresenterInterface: AnyObject {

}
