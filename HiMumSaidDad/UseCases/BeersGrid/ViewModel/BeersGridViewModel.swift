import Foundation
import UIKit
import RxSwift

protocol BeersGridViewModelInputs {

//    func load()
}

protocol BeersGridViewModelOutputs {

//    var showErrorView: Observable<Bool> { get }
//    var isLoading: Observable<Bool> { get }
//    var showCollectionView: Observable<Bool>  { get }
//    var cellViewModels: Observable<[HomeCollectionViewCellViewModelType]> { get }
}

protocol BeersGridViewModelType {

    var inputs: BeersGridViewModelInputs { get }
    var outputs: BeersGridViewModelOutputs { get }
}

class BeersGridViewModel: BeersGridViewModelType, BeersGridViewModelInputs, BeersGridViewModelOutputs {

    // MARK: - Properties

    var inputs: BeersGridViewModelInputs { return self }
    var outputs: BeersGridViewModelOutputs { return self }
//
//    let clothingRepository: BeersRepository
//    let imageRepository: ImageRepo
//
//    private(set) var showErrorView: Observable<Bool> = Observable(false)
//    private(set) var isLoading: Observable<Bool> = Observable(true)
//    private(set) var showCollectionView: Observable<Bool> = Observable(false)
//    private(set) var cellViewModels: Observable<[HomeCollectionViewCellViewModelType]> = Observable([HomeCollectionViewCellViewModelType]())
//
//    // MARK: - Init
//
//    init(clothingRepository: ClothingRepository,
//         imageRepository: ImageRepository) {
//
//        self.clothingRepository = clothingRepository
//        self.imageRepository = imageRepository
//    }
//
//    // MARK: - Inputs
//
//    func load() {
//
//        clothingRepository.fetchClothingItems { [weak self] result in
//
//            guard let self = self else {
//                return
//            }
//
//            self.isLoading.next(false)
//
//            switch result {
//
//            case .failure:
//
//                self.showErrorView.next(true)
//
//            case .success(let clothingItems):
//
//                clothingItems.forEach {
//
//                    let viewModel = HomeCollectionViewCellViewModel(model: $0,
//                                                                    imageRepository: self.imageRepository,
//                                                                    clothingRepository: self.clothingRepository)
//                    self.cellViewModels.value.append(viewModel)
//                }
//
//                self.showCollectionView.next(true)
//            }
//        }
//    }
}
