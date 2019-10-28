import UIKit
@testable import HiMumSaidDad

extension Beer {

    static func fake() -> Beer{
        return Beer(name: "a beer name", abv: 1.1, imageURLString: "www.a.url")
    }
}
