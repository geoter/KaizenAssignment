//
//  NetworkMock.swift
//  KaizenAssignmentTests
//
//  Created by George Termentzoglou on 10/9/22.
//

import Foundation
@testable import KaizenAssignment

final class NetworkMock: NetworkProtocol {
    private let responseData: Data
    
    init(stubResponse: Data) {
        self.responseData = stubResponse
    }
    
    func sendRequest<Request: Requestable>(request: Request, completion: @escaping (Result<Request.ResponseType, NetworkError>) -> Void, session: URLSession = .shared, jsonDecoder: JSONDecoder = JSONDecoder()) {
        guard let responseModel = try? jsonDecoder.decode(Request.ResponseType.self, from: responseData) else {
            completion(.failure(.decodeError("\(Request.ResponseType.self)")))
            return
        }
        completion(.success(responseModel))
    }
}
