import Foundation

protocol CoordinatorFactoryType {

    func makeBeersGrid() -> BeersGridCoordinatorType
}

struct CoordinatorFactory: CoordinatorFactoryType {

    func makeBeersGrid() -> BeersGridCoordinatorType {
        return BeersGridCoordinator()
//        let network = NetworkSession(session: URLSession.shared, domain: domain)
//        let database = UserDefaults.standard
//        let repository = Repository(network: network, database: database)
//        return HomeCoordinator(clothingRepository: repository, imageRepository: repository)
    }
}
