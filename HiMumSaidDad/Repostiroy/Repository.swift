import Foundation

protocol RepositoryType: BeersRepository,  ImageRepository {

}

class Repository: RepositoryType {

    let network: Network
    let database: Database
    
    init(network: Network, database: Database) {
        self.network = network
        self.database = database
    }
}
