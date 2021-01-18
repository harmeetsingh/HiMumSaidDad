import Foundation
import RxDataSources

protocol BeersGridHeaderViewModelType: IdentifiableType, Equatable {

}

struct BeersGridHeaderViewModel: BeersGridHeaderViewModelType {

    typealias Identity = String
    let identity = "BeersGridHeader"
}
