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
    
    // MARK: - Properties

    var outputs: BeerGridCellViewModelOutputs { return self }
    var inputs: BeerGridCellViewModelInputs { return self }
    
    let name: Driver<String>
    let abv: Driver<String> 
    let image: Driver<UIImage>
    
    private let beer: Beer
    private let imageRepository: ImageRepository
    private let loadRelay = PublishRelay<Void>()
    private let imageRelay = PublishRelay<UIImage>()

    typealias Identity = String
    let identity = "BeerGridCellViewModel"
    
    // MARK: - Lifecycle
    
    init(beer: Beer,
         imageRepository: ImageRepository) {
        self.beer = beer
        self.imageRepository = imageRepository
        name = .just(beer.name)
        abv = .just(String(describing:beer.abv))
        
        image = imageRepository
            .fetchImage(for: beer)
            .asDriver(onErrorJustReturn: UIImage())
    }
    
    // MARK: - Inputs

    func load() {
        loadRelay.accept(())
    }

    static func == (lhs: BeerGridCellViewModel, rhs: BeerGridCellViewModel) -> Bool {
        return lhs.identity == rhs.identity
    }
}
