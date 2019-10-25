import Foundation

struct BeersResponseDecoder: NetworkResponseDecoder {

    func decode(data: Data) throws -> Decodable {
        let decoder = JSONDecoder()
        return try decoder.decode([Beer].self, from: data)
    }
}
