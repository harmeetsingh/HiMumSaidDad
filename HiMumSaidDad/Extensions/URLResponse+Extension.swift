import Foundation

extension URLResponse {

    func isSuccessfull() -> Bool {

        guard let httpURLResponse = self as? HTTPURLResponse else {
            return false
        }

        return 200 ... 299 ~= httpURLResponse.statusCode
    }
}
