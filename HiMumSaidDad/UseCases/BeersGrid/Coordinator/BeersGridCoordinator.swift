import UIKit

protocol BeersGridCoordinatorType {

    func start(on window: UIWindow)
}

class BeersGridCoordinator: BeersGridCoordinatorType {
    
    private let beersRepository: BeersRepository
    private let imageRepository: ImageRepository
    private weak var presentingViewController: UIViewController?

    init(beersRepository: BeersRepository, imageRepository: ImageRepository) {
        self.beersRepository = beersRepository
        self.imageRepository = imageRepository
    }

    func start(on window: UIWindow) {
        let viewController: BeersGridViewController = .fromStoryboard()
        viewController.viewModel = BeersGridViewModel(beersRepository: beersRepository,
                                                      imageRepository: imageRepository)
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        
        presentingViewController = viewController
    }
}
