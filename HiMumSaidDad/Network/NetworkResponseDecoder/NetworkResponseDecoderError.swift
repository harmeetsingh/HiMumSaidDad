import Foundation

enum NetworkResponseDecoderError: Error, Equatable {
    
    case unexpectedResponseType
    case missingKey(String)
}
