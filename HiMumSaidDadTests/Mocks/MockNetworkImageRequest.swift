import Foundation
@testable import HiMumSaidDad

struct MockNetworkImageRequest: NetworkImageRequest {

    var url: URL = URL(string: "www.something.cool")!

}
