import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

protocol BeerGridCellViewModelInputs {

    func load()
}

protocol BeerGridCellViewModelOutputs {

    var name: Driver<String> { get }
    var abv: Driver<String>  { get }
    var image: Driver<UIImage> { get }
}

protocol BeerGridCellViewModelType: IdentifiableType, Equatable {

    var outputs: BeerGridCellViewModelOutputs { get }
    var inputs: BeerGridCellViewModelInputs { get }
}

class BeerGridCellViewModel: BeerGridCellViewModelType, BeerGridCellViewModelOutputs, BeerGridCellViewModelInputs {

    var outputs: BeerGridCellViewModelOutputs { return self }
    var inputs: BeerGridCellViewModelInputs { return self }
    
    let name: Driver<String>
    let abv: Driver<String> 
    let image: Driver<UIImage>
    
    private let beer: Beer
    private let imageRepository: ImageRepository
    private let imageRelay = PublishRelay<UIImage>()

    typealias Identity = String
    let identity = "BeerGridCellViewModel"
    
    init(beer: Beer,
         imageRepository: ImageRepository) {
        self.beer = beer
        self.imageRepository = imageRepository
        name = .just(beer.name)
        abv = .just(String(describing:beer.abv))

        image = imageRelay
            .asDriver(onErrorJustReturn: UIImage())
    }

    func load() {
        imageRepository.fetchImage(for: beer) { [weak self] result in
            switch result {
            case .success(let beerImage):
                guard let self = self else { return }
                self.imageRelay.accept(beerImage)
            default:
                break
            }
        }
    }

    static func == (lhs: BeerGridCellViewModel, rhs: BeerGridCellViewModel) -> Bool {
        return lhs.identity == rhs.identity
    }
}
