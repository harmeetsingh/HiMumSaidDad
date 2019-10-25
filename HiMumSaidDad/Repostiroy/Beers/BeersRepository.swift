import Foundation

protocol BeersRepository {

    func fetchAllBeers(completion: @escaping (Result<[Beer], Error>) -> Void)
}

extension Repository {

    func fetchAllBeers(completion: @escaping (Result<[Beer], Error>) -> Void) {

        let request = BeersRequest()
        let decoder = BeersResponseDecoder()

        network.load(request: request, decoder: decoder) { result in
         
            switch result {

            case .failure(let error):
                completion(.failure(error))

            case .success(let decodedData):

                guard let beers = decodedData as? [Beer] else {
                    completion(.failure(RepositoryError.unexpectedResponseType))
                    return
                }

                completion(.success(beers))
            }    
        }
    }
}
