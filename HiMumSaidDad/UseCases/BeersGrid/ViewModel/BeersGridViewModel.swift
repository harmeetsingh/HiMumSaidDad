import Foundation
import UIKit
import RxCocoa
import RxRelay
import RxSwift
import RxDataSources

typealias BeersGridSectionModel = AnimatableSectionModel<BeersGridHeaderViewModel, BeerGridCellViewModel>

protocol BeersGridViewModelInputs {

    func load()
}

protocol BeersGridViewModelOutputs {

    var showErrorView: Driver<Bool> { get }
    var showCollectionView: Driver<Bool> { get }
    var isLoading: Driver<Bool> { get }
    var section: Driver<[BeersGridSectionModel]> { get }
}

protocol BeersGridViewModelType {

    var inputs: BeersGridViewModelInputs { get }
    var outputs: BeersGridViewModelOutputs { get }
}

class BeersGridViewModel: BeersGridViewModelType, BeersGridViewModelInputs, BeersGridViewModelOutputs {

    // MARK: - Properties

    var inputs: BeersGridViewModelInputs { return self }
    var outputs: BeersGridViewModelOutputs { return self }

    private let beersRepository: BeersRepository
    private let imageRepository: ImageRepository

    let showErrorView: Driver<Bool>
    let showCollectionView: Driver<Bool>
    let isLoading: Driver<Bool>
    let section: Driver<[BeersGridSectionModel]>

    private let loadRelay = PublishRelay<Void>()

    // MARK: - Init

    init(beersRepository: BeersRepository,
         imageRepository: ImageRepository) {

        self.beersRepository = beersRepository
        self.imageRepository = imageRepository
        
        let activityIndicator = ActivityIndicator()
        let errorRelay = PublishRelay<Error>()
        
        showErrorView = errorRelay
            .map { _ in return true }
            .startWith(false)
            .asDriver(onErrorJustReturn: false)
        
        showCollectionView = showErrorView
            .startWith(false)
            .map(!)
        
        isLoading = activityIndicator
            .asDriver()

        section = loadRelay
            .flatMap { _ in  
                beersRepository
                    .fetchAllBeers()
                    .trackActivity(activityIndicator)
                    .trackErrors(with: errorRelay)
                    .map { beers -> [BeersGridSectionModel] in
                        let viewModels = beers.map { BeerGridCellViewModel(beer: $0, imageRepository: imageRepository) }
                        let headerViewModel = BeersGridHeaderViewModel()
                        return [BeersGridSectionModel(model: headerViewModel, items: viewModels)]
                    }
        }.asDriver(onErrorJustReturn: [])
    }

    // MARK: - Inputs

    func load() {
        loadRelay.accept(())
    }
}
