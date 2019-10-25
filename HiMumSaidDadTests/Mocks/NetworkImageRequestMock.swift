import Foundation
@testable import HiMumSaidDad

struct NetworkImageRequestMock: NetworkImageRequest {

    var url: URL = URL(string: "www.something.cool")!

}
