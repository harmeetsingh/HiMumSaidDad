//
//  MockNetwork.swift
//  HiMumSaidDadTests
//
//  Created by Harmeet Singh on 25/10/2019.
//  Copyright © 2019 Harmeet Singh. All rights reserved.
//

import Foundation
@testable import HiMumSaidDad

struct MockNetwork: Network {
    
    var returnError = false
    var responseObject: Decodable?

    func load(request: NetworkRequest, decoder: NetworkResponseDecoder, completion: @escaping (Result<Decodable, Error>) -> Void) {
        
        if returnError {
            completion(.failure(MockError.instance))
        } else if let responseObject = responseObject {
            completion(.success(responseObject))
        }
    }
    
    func loadImage(request: NetworkImageRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        
    }
}
