import XCTest
@testable import HiMumSaidDad

/// FYI - Tests in Given, When, Then format
class NetworkSessionTests: XCTestCase {

    // MARK: - Properties

    let networkRequest = NetworkRequestMock(endpoint: "/something/cool",
                                            query: "?A=1",
                                            method: HTTPMethodType.get,
                                            headers: nil,
                                            parameters: nil)

    let networkImageRequest = NetworkImageRequestMock()
    let responseDecoder = NetworkResponseDecoderMock()

    static var mockSession = SuperSession()
    var sut = NetworkSession(session: mockSession, domain: "domain")

    // MARK: - Init tests

    func testInit_DomainCorrectValue() {
        XCTAssertEqual(sut.domain, "domain")
    }

    // MARK: - Load failure scenario tests

    func testLoad_InvalidRequest_ReturnsNilURLError() {

        let networkRequest = NetworkRequestMock(endpoint: "",
                                                query: "",
                                                method: HTTPMethodType.get,
                                                headers: nil,
                                                parameters: nil)

        let mockSession = SuperSession()
        sut = NetworkSession(session: mockSession, domain: "")

        sut.load(request: networkRequest, decoder: responseDecoder) { result in

            switch result {

            case .failure(let error):

                let networkRequestError = error as? NetworkRequestError
                XCTAssertEqual(networkRequestError, NetworkRequestError.nilURL)

            default:
                break
            }
        }
    }

    func testLoad_ErrorReturned_ReturnsCorrectError() {

        let expectation = self.expectation(description: "testLoad_ErrorReturned_ReturnsCorrectError")

        let networkRequest = NetworkRequestMock(endpoint: "something/cool",
                                                query: nil,
                                                method: HTTPMethodType.get,
                                                headers: nil,
                                                parameters: nil)

        NetworkSessionTests.mockSession.stubDataTask(withError: MockError.instance)

        sut.load(request: networkRequest, decoder: responseDecoder) { result in

            switch result {

            case .failure(let error):

                let mockError = error as? MockError
                XCTAssertEqual(mockError, MockError.instance)
                expectation.fulfill()

            default:
                break
            }
        }

        wait(for: [expectation], timeout: 0.1)
    }

    func testLoad_RequestFailed_ReturnsCorrectError() {

        let expectation = self.expectation(description: "testLoad_RequestFailed_ReturnsCorrectError")

        let mockResponse = HTTPURLResponse(url: URL(string: "url")!,
                                           statusCode: 401,
                                           httpVersion: "1.1",
                                           headerFields: nil)

        NetworkSessionTests.mockSession.stubDataTask(withResponse: mockResponse)

        sut.load(request: networkRequest, decoder: responseDecoder) { result in

            switch result {

            case .failure(let error):

                let networkSessionError = error as? NetworkSessionError
                XCTAssertEqual(networkSessionError, NetworkSessionError.unsuccessfulRequest(mockResponse))
                expectation.fulfill()

            default:
                break
            }
        }

        wait(for: [expectation], timeout: 0.1)
    }

    func testLoad_NilResponseData_ReturnsCorrectError() {

        let expectation = self.expectation(description: "testLoad_NilResponseData_ReturnsCorrectError")

        let mockResponse = HTTPURLResponse(url: URL(string: "url")!,
                                           statusCode: 200,
                                           httpVersion: "1.1",
                                           headerFields: nil)

        NetworkSessionTests.mockSession.stubDataTask(with: nil, response: mockResponse, error: nil)

        sut.load(request: networkRequest, decoder: responseDecoder) { result in

            switch result {

            case .failure(let error):

                let networkSessionError = error as? NetworkSessionError
                XCTAssertEqual(networkSessionError, NetworkSessionError.nilResponseData)
                expectation.fulfill()

            default:
                break
            }
        }

        wait(for: [expectation], timeout: 0.1)
    }

    // MARK: - Load success scenario tests

    func testLoad_ResponseDataUnexpectedFormat_ReturnsCorrectError() {

        let expectation = self.expectation(description: "testLoad_ResponseDataUnexpectedFormat_ReturnsCorrectError")

        let mockResponse = HTTPURLResponse(url: URL(string: "url")!,
                                           statusCode: 200,
                                           httpVersion: "1.1",
                                           headerFields: nil)

        let mockData = "something".data(using: .utf8)

        NetworkSessionTests.mockSession.stubDataTask(with: mockData, response: mockResponse, error: nil)

        sut.load(request: networkRequest, decoder: responseDecoder) { result in

            switch result {

            case .success(let decodedData):
                XCTAssertEqual(decodedData as? String, "a string was decoded")
                expectation.fulfill()
            default:
                break
            }
        }

        wait(for: [expectation], timeout: 0.2)
    }

    // MARK: - Load image failure scenario tests

    func testLoadImage_ErrorReturned_ReturnsCorrectError() {

        let expectation = self.expectation(description: "testLoadImage_ErrorReturned_ReturnsCorrectError")

        NetworkSessionTests.mockSession.stubDataTask(withError: MockError.instance)

        sut.loadImage(request: networkImageRequest) { result in

            switch result {

            case .failure(let error):

                let mockError = error as? MockError
                XCTAssertEqual(mockError, MockError.instance)
                expectation.fulfill()

            default:
                break
            }
        }

        wait(for: [expectation], timeout: 0.1)
    }

    func testLoadImage_RequestFailed_ReturnsCorrectError() {

        let expectation = self.expectation(description: "testLoadImage_RequestFailed_ReturnsCorrectError")

        let mockResponse = HTTPURLResponse(url: URL(string: "url")!,
                                           statusCode: 401,
                                           httpVersion: "1.1",
                                           headerFields: nil)

        NetworkSessionTests.mockSession.stubDataTask(withResponse: mockResponse)

        sut.loadImage(request: networkImageRequest) { result in

            switch result {

            case .failure(let error):

                let networkSessionError = error as? NetworkSessionError
                XCTAssertEqual(networkSessionError, NetworkSessionError.unsuccessfulRequest(mockResponse))
                expectation.fulfill()

            default:
                break
            }
        }

        wait(for: [expectation], timeout: 0.1)
    }

    func testLoadImage_NilResponseData_ReturnsCorrectError() {

        let expectation = self.expectation(description: "testLoadImage_NilResponseData_ReturnsCorrectError")

        let mockResponse = HTTPURLResponse(url: URL(string: "url")!,
                                           statusCode: 200,
                                           httpVersion: "1.1",
                                           headerFields: nil)

        NetworkSessionTests.mockSession.stubDataTask(with: nil, response: mockResponse, error: nil)

        sut.loadImage(request: networkImageRequest) { result in

            switch result {

            case .failure(let error):

                let networkSessionError = error as? NetworkSessionError
                XCTAssertEqual(networkSessionError, NetworkSessionError.nilResponseData)
                expectation.fulfill()

            default:
                break
            }
        }

        wait(for: [expectation], timeout: 0.1)
    }

    // MARK: - Load success scenario tests

    func testLoadImage_ResponseDataUnexpectedFormat_ReturnsCorrectError() {

        let expectation = self.expectation(description: "testLoadImage_ResponseDataUnexpectedFormat_ReturnsCorrectError")

        let mockResponse = HTTPURLResponse(url: URL(string: "url")!,
                                           statusCode: 200,
                                           httpVersion: "1.1",
                                           headerFields: nil)

                
        let testBundle = Bundle(for: NetworkSessionTests.self)
        let fileURL = testBundle.url(forResource: "tick", withExtension: "jpg")!
        let mockData = try! Data(contentsOf: fileURL)

        NetworkSessionTests.mockSession.stubDataTask(with: mockData, response: mockResponse, error: nil)

        sut.loadImage(request: networkImageRequest) { result in

            switch result {

            case .success(let responseImageData):
                let actualImage = UIImage(data: responseImageData)
                let expectedImage = UIImage(data: mockData)
                XCTAssertEqual(actualImage?.pngData(), expectedImage?.pngData())
                expectation.fulfill()
            default:
                break
            }
        }

        wait(for: [expectation], timeout: 0.1)
    }
}
