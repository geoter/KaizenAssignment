//
//  NetworkMock.swift
//  KaizenAssignmentTests
//
//  Created by George Termentzoglou on 10/9/22.
//

import Foundation
@testable import KaizenAssignment

final class NetworkMock: NetworkProtocol {
    var config: NetworkConfig
    
    private let responseData: Data
    
    init(stubResponse: Data) {
        self.responseData = stubResponse
        config = NetworkConfig(scheme: "https", host: "618d3aa7fe09aa001744060a.mockapi.io",
                                            reachability: .shared, session: .shared)
    }
    
    func sendRequest<Request: Requestable>(request: Request, completion: @escaping (Result<Request.ResponseType, NetworkError>) -> Void) {
        let jsonDecoder = JSONDecoder()
        guard let responseModel = try? jsonDecoder.decode(Request.ResponseType.self, from: responseData) else {
            completion(.failure(.decodeError("\(Request.ResponseType.self)")))
            return
        }
        completion(.success(responseModel))
    }
}
