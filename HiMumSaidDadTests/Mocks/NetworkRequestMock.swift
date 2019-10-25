import Foundation
@testable import HiMumSaidDad

struct NetworkRequestMock: NetworkRequest {

    let endpoint: String
    let query: String?
    let method: HTTPMethodType
    let headers: [String : String]?
    let parameters: [String : AnyObject]?
}

