
import Foundation

struct BeerImageRequest: NetworkImageRequest {

    // MARK: - Properties

    let url: URL

    // MARK: - Init

    init?(urlString: String) {

        guard let url = URL(string: urlString) else {
            return nil
        }

        self.url = url
    }
}
