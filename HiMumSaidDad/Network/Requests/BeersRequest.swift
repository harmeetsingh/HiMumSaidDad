import Foundation

struct BeersRequest: NetworkRequest {

    let endpoint: String = "/v2/beers"
    let query: String? = nil
    let method: HTTPMethodType = .get
    let headers: [String : String]? = nil
    let parameters: [String : AnyObject]? = nil
}
