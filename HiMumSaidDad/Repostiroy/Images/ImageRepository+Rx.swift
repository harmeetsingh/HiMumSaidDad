//
//  ImageRepository+Rx.swift
//  HiMumSaidDad
//
//  Created by Harmeet Singh on 18/01/2021.
//

import Foundation
import RxSwift
import RxCocoa

extension ImageRepository {

    func fetchImage(for beer: Beer) -> Single<UIImage> {
        return Single.create { single in
            let disposable = Disposables.create()
            self.fetchImage(for: beer) { result in
                switch result {
                case .success(let image):
                    single(.success(image))
                case .failure(let error):
                    single(.error(error))
                }
            }
            return disposable
        }
    }
}
