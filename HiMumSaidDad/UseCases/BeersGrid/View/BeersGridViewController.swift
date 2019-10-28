import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class BeersGridViewController: UIViewController {

    @IBOutlet var loadingView: UIView!
    @IBOutlet var errorView: UIView!
    @IBOutlet var collectionView: UICollectionView!
    var viewModel: BeersGridViewModelType! 
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        bind(viewModel.outputs)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.inputs.load()
    }
    
    func bind(_ outputs: BeersGridViewModelOutputs) {

        outputs.isLoading
            .drive(loadingView.rx.isVisible)
            .disposed(by: disposeBag)
        
        outputs.showErrorView
            .drive(errorView.rx.isVisible)
            .disposed(by: disposeBag)
        
        outputs.showCollectionView
            .drive(collectionView.rx.isVisible)
            .disposed(by: disposeBag)
        
        let datasource = makeDatasource()
        outputs.section
            .drive(collectionView.rx.items(dataSource: datasource))
            .disposed(by: disposeBag)
    }

    func makeDatasource() -> RxCollectionViewSectionedAnimatedDataSource<BeersGridSectionModel> {        
        return RxCollectionViewSectionedAnimatedDataSource<BeersGridSectionModel>(
        configureCell: { (dataSource, collectionView, indexPath, _) -> UICollectionViewCell in

            guard let viewModel = dataSource.sectionModels.first?.items[indexPath.row] else {
                return UICollectionViewCell()
            }
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BeersGridCollectionViewCell", for: indexPath) as? BeersGridCollectionViewCell else {
                return UICollectionViewCell()
            } 

            cell.viewModel = viewModel
            cell.viewModel.load()
            return cell
        })
    }
}
