import Foundation
@testable import HiMumSaidDad

struct NetworkResponseDecoderMock: NetworkResponseDecoder {

    func decode(data: Data) throws -> Decodable {
        return "a string was decoded"
    }
}
