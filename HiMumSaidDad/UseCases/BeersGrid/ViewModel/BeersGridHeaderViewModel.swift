import Foundation
import RxDataSources

protocol BeersGridHeaderViewModelType: IdentifiableType {

}

struct BeersGridHeaderViewModel: BeersGridHeaderViewModelType {

    typealias Identity = String
    let identity = "BeersGridHeader"
}
