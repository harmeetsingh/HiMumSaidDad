import Foundation

protocol CoordinatorFactoryType {

    func makeBeersList() -> BeersListCoordinatorType
}

struct CoordinatorFactory: CoordinatorFactoryType {

    func makeBeersList() -> BeersListCoordinatorType {
        return BeersListCoordinator()
//        let network = NetworkSession(session: URLSession.shared, domain: domain)
//        let database = UserDefaults.standard
//        let repository = Repository(network: network, database: database)
//        return HomeCoordinator(clothingRepository: repository, imageRepository: repository)
    }
}
