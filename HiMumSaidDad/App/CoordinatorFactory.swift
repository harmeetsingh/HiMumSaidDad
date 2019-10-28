import Foundation

protocol CoordinatorFactoryType {

    func makeBeersGrid() -> BeersGridCoordinatorType
}

struct CoordinatorFactory: CoordinatorFactoryType {
    
    private let repository: RepositoryType
    
    init(network: Network, database: Database) {
        self.repository = Repository(network: network, database: database)
    }

    func makeBeersGrid() -> BeersGridCoordinatorType {
        return BeersGridCoordinator(beersRepository: repository, 
                                    imageRepository: repository)
    }
}
