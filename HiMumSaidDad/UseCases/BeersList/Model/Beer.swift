import Foundation

struct Beer: Codable {

    let name: String
    let abv: Int
    let imageURLString: String

    enum CodingKeys: String, CodingKey {

        case name, abv
        case imageURLString = "image_url"
    }
}
