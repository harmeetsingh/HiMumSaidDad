import UIKit

struct NetworkImageResponseDecoder {

    func decode(data: Data) throws -> UIImage {

        guard let image =  UIImage(data: data) else {
            throw NetworkImageResponseDecoderError.nilImage
        }

        return image
    }
}
