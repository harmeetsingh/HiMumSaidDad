import XCTest
import RxSwift
import RxCocoa
import RxTest
import RxDataSources
@testable import HiMumSaidDad

class BeersGridViewModelTests: XCTestCase {

    private let mockRepository = MockRepository()
    private var sut: BeersGridViewModel!
    private let disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        sut = BeersGridViewModel(beersRepository: mockRepository, imageRepository: mockRepository)
    }
    
    // TODO: Add tests for showErrorView, showCollectionView, isLoading

    func testLoad_FetchClothingItemsFailed_CellViewModelsCorrectValue() {
        mockRepository.fetchAllBeersCompletion = .failure(MockError.instance)
        let scheduler = TestScheduler(initialClock: 0)
        let recordedObject = scheduler.record(sut.section)

        sut.load()

        XCTAssertEqual(recordedObject.events, [])
    }

    func testLoad_FetchClothingItemsSuccessful_CellViewModelsCorrectValue() {
        let model = Beer(name: "", abv: 0, imageURLString: "")
        mockRepository.fetchAllBeersCompletion = .success([model])
        let scheduler = TestScheduler(initialClock: 0)
        let recordedObject = scheduler.record(sut.section)

        sut.load()

        let viewModels = [BeerGridCellViewModel(beer: model, imageRepository: mockRepository)]
        let models = [BeersGridSectionModel(model: BeersGridHeaderViewModel(), items: viewModels)]
        XCTAssertEqual(recordedObject.events, [.next(0, models)])
    }
}


extension TestScheduler {
    /// Creates a `TestableObserver` instance which immediately subscribes
    /// to the `source` and disposes the subscription at virtual time 100000.
    func record<O: ObservableConvertibleType>(_ source: O) -> TestableObserver<O.Element> {
        let observer = self.createObserver(O.Element.self)
        let disposable = source.asObservable().bind(to: observer)
        self.scheduleAt(100000) {
            disposable.dispose()
        }
        return observer
    }
}
