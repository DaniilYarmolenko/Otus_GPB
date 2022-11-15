import UIKit

class ThirdWireframe {
        // MARK: - VIPER Stack
        lazy var moduleInteractor = ThirdInteractor()
        // Uncomment to use a navigationController from storyboard
        /*
        lazy var moduleNavigationController: UINavigationController = {
                let sb = ThirdWireframe.storyboard()
                let nc = (sb.instantiateViewController(withIdentifier: ThirdConstants.navigationControllerIdentifier) as? UINavigationController)!
                return nc
        }()
        */
        lazy var modulePresenter = ThirdPresenter()
        lazy var moduleView: ThirdView = {
                // Uncomment the commented line below and delete the storyboard
                //      instantiation to use a navigationController from storyboard
                //let vc = self.moduleNavigationController.viewControllers[0] as! ThirdView
                let sb = ThirdWireframe.storyboard()
                let vc = (sb.instantiateViewController(withIdentifier: ThirdConstants.viewIdentifier) as? ThirdView)!
                _ = vc.view
                return vc
        }()

        // MARK: - Computed VIPER Variables
        lazy var presenter: ThirdWireframeToPresenterInterface = self.modulePresenter
        lazy var view: ThirdNavigationInterface = self.moduleView

        // MARK: - Instance Variables

        // MARK: - Initialization
        init() {
                let i = moduleInteractor
                let p = modulePresenter
                let v = moduleView

                i.presenter = p

                p.interactor = i
                p.view = v
                p.wireframe = self

                v.presenter = p
        }

    	class func storyboard() -> UIStoryboard {
                return UIStoryboard(
                    name: ThirdConstants.storyboardIdentifier,
                    bundle: Bundle(for: ThirdWireframe.self)
                )
    	}

        // MARK: - Operational

}

// MARK: - Module Interface
extension ThirdWireframe: Third {
        var delegate: ThirdDelegate? {
                get {
                        return presenter.delegate
                }
                set {
                        presenter.set(delegate: newValue)
                }
        }
}

// MARK: - Presenter to Wireframe Interface
extension ThirdWireframe: ThirdPresenterToWireframeInterface {

}

// MARK: - Communication Interfaces
// Interface Abstraction for working with the VIPER Module
protocol Third: AnyObject {
        var delegate: ThirdDelegate? { get set }
}

// VIPER Module Constants
struct ThirdConstants {
        // Uncomment to utilize a navigation controller from storyboard
        //static let navigationControllerIdentifier = "ThirdNavigationController"
        static let storyboardIdentifier = "Third"
        static let viewIdentifier = "ThirdView"
}

// VIPER Interface for manipulating the navigation of the view
protocol ThirdNavigationInterface: AnyObject {

}

// VIPER Interface for communication from Wireframe -> Presenter
protocol ThirdWireframeToPresenterInterface: AnyObject {
        var delegate: ThirdDelegate? { get }
        func set(delegate newDelegate: ThirdDelegate?)
}
