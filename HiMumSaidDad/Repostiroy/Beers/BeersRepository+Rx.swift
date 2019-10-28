import Foundation
import RxSwift
import RxCocoa

extension BeersRepository {

    func fetchAllBeers() -> Single<[Beer]> {
        return Single.create { single in
            let disposable = Disposables.create()
            self.fetchAllBeers { result in
                switch result {
                case .success(let beers):
                    single(.success(beers))
                case .failure(let error):
                    single(.error(error))
                }
            }
            return disposable
        }
    }
}
