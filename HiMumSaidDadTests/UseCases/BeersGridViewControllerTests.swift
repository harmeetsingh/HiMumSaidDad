import XCTest
 @testable import HiMumSaidDad

class BeersGridViewControllerTests: XCTestCase {
    
    let sut: BeersGridViewController = .fromStoryboard()
    
    override func setUp() {

        sut.viewModel = BeersGridViewModelMock()
        _ = sut.view
    }

    func testErrorView_IsHidden_BindsCorrectlyValue() {

        XCTAssertEqual(sut.errorView.isHidden, true)
    }

    func testLoadingView_IsLoading_BindsCorrectlyValue() {

        XCTAssertEqual(sut.loadingView.isHidden, true)
    }

    func testCollectionView_CellsCount_BindsCorrectlyValue() {

        let numberOfCells = sut.collectionView.numberOfItems(inSection: 0)
        XCTAssertEqual(numberOfCells, 1)
    }
}
