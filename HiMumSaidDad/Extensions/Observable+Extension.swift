import Foundation
import RxSwift
import RxCocoa

extension ObservableType {
    
    func trackErrors(with relay: PublishRelay<Error>) -> Observable<Self.Element> {
        return catchError { [weak relay] error in
            relay?.accept(error)
            return Observable.empty()
        }
    }
}

