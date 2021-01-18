import Foundation
@testable import HiMumSaidDad

struct MockNetworkResponseDecoder: NetworkResponseDecoder {

    func decode(data: Data) throws -> Decodable {
        return "a string was decoded"
    }
}
