//
//  Network.swift
//  KaizenAssignment
//
//  Created by George Termentzoglou on 10/9/22.
//

import Foundation

protocol NetworkProtocol {
    var config: NetworkConfig { get }
    func sendRequest<Request: Requestable>(request: Request, completion: @escaping (Result<Request.ResponseType, NetworkError>) -> Void)
}

final class Network: NetworkProtocol {
    static let shared: NetworkProtocol = {
        guard !ProcessInfo.processInfo.arguments.contains(EnvArgs.NetworkMock) else { //used in UITests
            let jsonData: Data = FileReader().read(from: "sports_response.json")!
            return NetworkMock(stubResponse: jsonData)
        }
        let config = NetworkConfig(scheme: "https", host: "618d3aa7fe09aa001744060a.mockapi.io",
                                   reachability: .shared, session: .shared)
        return Network(config: config)
    }()
    
    private(set) var config: NetworkConfig
    
    init(config: NetworkConfig) {
        self.config = config
    }
    
    func sendRequest<Request: Requestable>(request: Request, completion: @escaping (Result<Request.ResponseType, NetworkError>) -> Void) {
        guard config.reachability.hasInternetConnection else {
            completion(.failure(.noInternet))
            return
        }
        guard let url = constructURL(path: request.path) else {
            /// Return completion block with error
            completion(.failure(.invalidPath(request.path)))
            return
        }
        let jsonDecoder = JSONDecoder()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
        urlRequest.timeoutInterval = 20.0
        
        let task = config.session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion(.failure(.requestFailed(request.path, error?.localizedDescription)))
                return
            }
            guard let httpResponse =  response as? HTTPURLResponse else {
                completion(.failure(.noResponse));
                return
            }
            guard httpResponse.statusCode == HTTPStatusCode.success .rawValue else {
                completion(.failure(.statusCode(httpResponse.statusCode)))
                return
            }
            guard let responseData = data else {
                completion(.failure(.noResponseData))
                return
            }
            if let responseModel = try? jsonDecoder.decode(Request.ResponseType.self, from: responseData) {
                completion(.success(responseModel))
                return
            }
            completion(.failure(.decodeError("\(Request.ResponseType.self)")))
        }
        task.resume()
    }
    
    private func constructURL(path: String) -> URL? {
        var components = URLComponents()
        components.scheme = config.scheme
        components.host = config.host
        components.path = path
        return components.url
    }
}
