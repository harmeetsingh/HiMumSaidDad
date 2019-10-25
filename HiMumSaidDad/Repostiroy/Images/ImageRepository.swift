import UIKit

protocol ImageRepository {

    func fetchImage(for beer: Beer, completion: @escaping (Result<UIImage, Error>) -> Void)
}

extension Repository {

    func fetchImage(for beer: Beer, completion: @escaping (Result<UIImage, Error>) -> Void) {
        
        guard let request = BeerImageRequest(urlString: beer.imageURLString) else {
            completion(.failure(RepositoryError.nilRequest))
            return
        }

        network.loadImage(request: request) { result in

            switch result {

            case .failure(let error):
                completion(.failure(error))

            case .success(let imageData):
                guard let image = UIImage(data: imageData) else {
                    completion(.failure(RepositoryError.unexpectedResponseType))
                    return
                }

                completion(.success(image))
            }
        }
    }
}
