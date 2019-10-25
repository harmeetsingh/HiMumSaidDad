import UIKit

protocol BeersListCoordinatorType {

    func start(on window: UIWindow)
}

struct BeersListCoordinator: BeersListCoordinatorType {

    func start(on window: UIWindow) {

        let beersListViewController: BeersListViewController = .fromStoryboard()
        window.rootViewController = beersListViewController
        window.makeKeyAndVisible()
    }
}
