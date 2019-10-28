import UIKit
import RxSwift
import RxCocoa

class BeersGridCollectionViewCell: UICollectionViewCell {
    @IBOutlet var beerImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var abvLabel: UILabel!
    @IBOutlet var favouriteButton: UIButton!
    
    var viewModel: BeerGridCellViewModel!
    private let disposeBag = DisposeBag()

    override func prepareForReuse() {
        nameLabel.text = ""
        abvLabel.text = ""
        beerImageView.image = nil
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        bind(viewModel.outputs)
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
