import Foundation
import RxSwift
import RxCocoa
import UIKit

extension Reactive where Base: UIView {

    public var isVisible: Binder<Bool> {
        return Binder(self.base) { view, isVisible in
            view.isHidden = !isVisible
        }
    }
}
