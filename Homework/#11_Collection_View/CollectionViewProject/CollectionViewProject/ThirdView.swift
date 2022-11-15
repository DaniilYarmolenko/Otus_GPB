import UIKit

class ThirdView: UIViewController {
        // MARK: - VIPER Stack
        weak var presenter: ThirdViewToPresenterInterface!

        // MARK: - Instance Variables

        // MARK: - Outlets

        // MARK: - Operational

}

// MARK: - Navigation Interface
extension ThirdView: ThirdNavigationInterface { }

// MARK: - Presenter to View Interface
extension ThirdView: ThirdPresenterToViewInterface {

}

// MARK: - Communication Interfaces
// VIPER Interface for communication from View -> Presenter
protocol ThirdViewToPresenterInterface: AnyObject {

}
