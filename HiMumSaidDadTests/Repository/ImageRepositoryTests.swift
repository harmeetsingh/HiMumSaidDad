//
//  BeersRepository.swift
//  HiMumSaidDadTests
//
//  Created by Harmeet Singh on 25/10/2019.
//  Copyright © 2019 Harmeet Singh. All rights reserved.
//

import XCTest
@testable import HiMumSaidDad

class ImageRepositoryTests: XCTestCase {

    static var mockNetwork = MockNetwork()
    static var mockDatabase = MockDatabase()
    let sut = Repository(network: mockNetwork, database: mockDatabase)
    let beer = Beer(name: "Name", abv: 1.2, imageURLString: "www.hello.com")

    func testFetchImage_LoadFailed_ReturnsRandomError() {

        ImageRepositoryTests.mockNetwork.returnError = true

        sut.fetchImage(for: beer) { result in

            switch result {

            case .failure(let error):

                let mockError = error as? MockError
                XCTAssertEqual(mockError, MockError.instance)
            default:
                break
            }
        }
    }

    func testFetchImage_LoadSuccessful_ReturnCorrectObjectType() {

        let testBundle = Bundle(for: NetworkSessionTests.self)
        let fileURL = testBundle.url(forResource: "tick", withExtension: "jpg")!
        let mockData = try! Data(contentsOf: fileURL)
        let localImage = UIImage(data: mockData)

        ImageRepositoryTests.mockNetwork.responseObject = mockData

        sut.fetchImage(for: beer) { result in

            switch result {

            case .success(let object):

                XCTAssertEqual(object.pngData(), localImage?.pngData())
            default:
                break
            }
        }
    }

}
