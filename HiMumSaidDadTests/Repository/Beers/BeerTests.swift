//
//  BeerTests.swift
//  HiMumSaidDadTests
//
//  Created by Harmeet Singh on 25/10/2019.
//  Copyright © 2019 Harmeet Singh. All rights reserved.
//

import XCTest
@testable import HiMumSaidDad

class BeerTests: XCTestCase {

    func testInit_WithValidJSON_ErrorNotThrown() {

        let filePath = Bundle(for: BeerTests.self).path(forResource: "beer-valid", ofType: "json")!
        let fileURL = URL(fileURLWithPath: filePath)
        let validData = try! Data(contentsOf: fileURL)

        let decoder = JSONDecoder()
        XCTAssertNoThrow(try decoder.decode(Beer.self, from: validData))
    }
    
    func testInit_WithInvalidJSON_ErrorThrown() {

        let filePath = Bundle(for: BeerTests.self).path(forResource: "beer-invalid", ofType: "json")!
        let fileURL = URL(fileURLWithPath: filePath)
        let validData = try! Data(contentsOf: fileURL)

        let decoder = JSONDecoder()
        XCTAssertThrowsError(try decoder.decode(Beer.self, from: validData))
    }
}
