//
//  BeersRepository.swift
//  HiMumSaidDadTests
//
//  Created by Harmeet Singh on 25/10/2019.
//  Copyright © 2019 Harmeet Singh. All rights reserved.
//

import XCTest
@testable import HiMumSaidDad

class RepositoryTests: XCTestCase {

    static var mockNetwork = MockNetwork()
    static var mockDatabase = MockDatabase()
    let sut = Repository(network: mockNetwork, database: mockDatabase)
    
    func testFetchClothingItems_LoadFailed_ReturnsRandomError() {

        RepositoryTests.mockNetwork.returnError = true

        sut.fetchAllBeers() { result in

            switch result {

            case .failure(let error):

                let mockError = error as? MockError
                XCTAssertEqual(mockError, MockError.instance)
            default:
                break
            }
        }
    }

    func testFetchClothingItems_LoadSuccessful_ReturnsUnexpectedResponseTypeError() {

        RepositoryTests.mockNetwork.responseObject = ""

        sut.fetchAllBeers() { result in

            switch result {

            case .failure(let error):

                let repositoryError = error as? RepositoryError
                XCTAssertEqual(repositoryError, RepositoryError.unexpectedResponseType)
            default:
                break
            }
        }
    }

    func testFetchClothingItems_LoadSuccessful_ReturnCorrectObjectType() {
        
        RepositoryTests.mockNetwork.responseObject = [Beer(name: "Name", abv: 1.2, imageURLString: "")]

        sut.fetchAllBeers() { result in

            switch result {

            case .success(let object):
                XCTAssertEqual(object.count, 1)
            default:
                break
            }
        }
    }
}
