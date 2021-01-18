import UIKit
@testable import HiMumSaidDad

class MockRepository: RepositoryType {

    var fetchAllBeersCompletion: Result<[Beer], Error> = .failure(MockError.instance)
    func fetchAllBeers(completion: @escaping (Result<[Beer], Error>) -> Void) {
        completion(fetchAllBeersCompletion)
    }
    
    func fetchImage(for beer: Beer, completion: @escaping (Result<UIImage, Error>) -> Void) {
        
    }
}
