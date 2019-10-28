import XCTest
import RxSwift
import RxCocoa
import RxTest
@testable import HiMumSaidDad

class BeersGridViewModelTests: XCTestCase {

    static let repositoryMock = RepositoryMock()
    let sut = BeersGridViewModel(beersRepository: repositoryMock, imageRepository: repositoryMock)
    
    func testLoad_IsLoadingCorrectValue() {
        let scheduler = TestScheduler(initialClock: 0)
        Recorded(time: 0, value: )
        let recordedOutputs = scheduler.record(sut.outputs.isLoading)
        sut.load()
        
        XCTAssertEqual(recordedOutputs.events, Event.r§ wecord(just: "useraccount.screen.title"))
    }

    func testLoad_FetchClothingItemsFailed_ShowErrorViewCorrectValue() {

        let expextation = self.expectation(description: "testLoad_FetchClothingItemsFailed_ShowErrorViewCorrectValue")

        HomeViewModelTests.mockRepository.error = MockError.randomError

        viewModel.load()

        _ = viewModel.showErrorView.observe { event in

            XCTAssertEqual(event.element, true)
            expextation.fulfill()
        }

        wait(for: [expextation], timeout: 0.1)
    }

    func testLoad_FetchClothingItemsSuccessful_CellViewModelsCorrectValue() {

        let expextation = self.expectation(description: "testLoad_FetchClothingItemsFailed_ShowErrorViewCorrectValue")

        HomeViewModelTests.mockRepository.responseObject = XCTestCase.validClothingItems()!

        viewModel.load()

        _ = viewModel.cellViewModels.observe { event in

            XCTAssertEqual(event.element?.count, 1)
            expextation.fulfill()
        }

        wait(for: [expextation], timeout: 0.5)
    }

    func testLoad_FetchClothingItemsSuccessful_ShowCollectionViewCorrectValue() {

        let expextation = self.expectation(description: "testLoad_FetchClothingItemsSuccessful_ShowCollectionViewCorrectValue")

        HomeViewModelTests.mockRepository.responseObject = XCTestCase.validClothingItems()!

        viewModel.load()

        _ = viewModel.showCollectionView.observe { event in

            XCTAssertEqual(event.element, true)
            expextation.fulfill()
        }

        wait(for: [expextation], timeout: 0.1)
    }

}
