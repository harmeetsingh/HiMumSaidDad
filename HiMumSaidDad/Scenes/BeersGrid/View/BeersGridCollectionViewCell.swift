import UIKit
import RxSwift
import RxCocoa

class BeersGridCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties

    @IBOutlet var beerImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var abvLabel: UILabel!
    @IBOutlet var favouriteButton: UIButton!
    
    var viewModel: BeerGridCellViewModel! {
        didSet {
            bind(viewModel.outputs)
        }
    }
    private let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle

    override func prepareForReuse() {
        nameLabel.text = ""
        abvLabel.text = ""
        beerImageView.image = nil
    }

    func bind(_ outputs: BeerGridCellViewModelOutputs) {
        outputs.name
            .drive(nameLabel.rx.text)
            .disposed(by: disposeBag)

        outputs.abv
            .drive(abvLabel.rx.text)
            .disposed(by: disposeBag)

        outputs.image
            .drive(beerImageView.rx.image)
            .disposed(by: disposeBag)
    }
}
