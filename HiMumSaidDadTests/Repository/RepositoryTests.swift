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

    static var networkMock = NetworkMock()
    static var databaseMock = DatabaseMock()
    let sut = Repository(network: networkMock, database: databaseMock)
    
    func testFetchClothingItems_LoadFailed_ReturnsRandomError() {

        RepositoryTests.networkMock.returnError = true

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

        RepositoryTests.networkMock.responseObject = ""

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
        
        RepositoryTests.networkMock.responseObject = [Beer(name: "Name", abv: 1.2, imageURLString: "")]

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
