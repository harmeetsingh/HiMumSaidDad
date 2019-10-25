import Foundation

struct Beer: Codable {

    let name: String
    let abv: Double
    let imageURLString: String

    enum CodingKeys: String, CodingKey {

        case name, abv
        case imageURLString = "image_url"
    }
}
