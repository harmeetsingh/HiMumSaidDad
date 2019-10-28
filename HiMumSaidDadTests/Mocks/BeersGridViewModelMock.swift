import Foundation
@testable import HiMumSaidDad
import RxSwift
import RxCocoa

struct BeersGridViewModelMock: BeersGridViewModelType, BeersGridViewModelInputs, BeersGridViewModelOutputs {
    func load() {
    }
    

    var inputs: BeersGridViewModelInputs { return self }
    var outputs: BeersGridViewModelOutputs  { return self }
    
    var showErrorView: Driver<Bool> = .just(false)
    var showCollectionView: Driver<Bool> = .just(false)
    var isLoading: Driver<Bool> = .just(false)

    var section: Driver<[BeersGridSectionModel]> = .just([BeersGridSectionModel(model: BeersGridHeaderViewModel(), 
                                                                                items: [BeerGridCellViewModel(beer: Beer.fake(), 
                                                                                                              imageRepository: RepositoryMock())])])    
}
