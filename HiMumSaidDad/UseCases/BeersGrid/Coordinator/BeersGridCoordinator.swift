import UIKit

protocol BeersGridCoordinatorType {

    func start(on window: UIWindow)
}

struct BeersGridCoordinator: BeersGridCoordinatorType {

    func start(on window: UIWindow) {

        let BeersGridViewController: BeersGridViewController = .fromStoryboard()
        window.rootViewController = BeersGridViewController
        window.makeKeyAndVisible()
    }
}
