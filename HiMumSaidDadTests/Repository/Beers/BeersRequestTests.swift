import XCTest
@testable import HiMumSaidDad

class BeersRequestTests: XCTestCase {
    
    let sut = BeersRequest()

    func testInit_EndpointCorrectValue() {
        XCTAssertEqual(sut.endpoint, "/v2/beers")
    }
    
    func testInit_MethodCorrectValue() {
        XCTAssertEqual(sut.method.rawValue, "GET")
    }
}
