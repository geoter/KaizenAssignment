//
//  NetworkError.swift
//  KaizenAssignment
//
//  Created by George Termentzoglou on 10/9/22.
//

import Foundation
import os.log

enum NetworkError: Error, LocalizedError {
    case invalidPath(String) /// associated value is the Path that caused the error
    case requestFailed(String, String?)
    case noResponse
    case noResponseData
    case statusCode(Int)
    case decodeError(String)
    case noInternet
    
    var errorDescription: String? {
        var errorMessage: String!
        switch self {
        case .invalidPath(let message):
            errorMessage = "\(message) is not valid. Please provide a valid subpath"
        case .requestFailed(let path, let errMessage):
            errorMessage = "Request to path \(path) failed with error: \(errMessage ?? "No message"))"
        case .noResponse:
            errorMessage = "No Response received"
        case .noResponseData:
            errorMessage = "No Response Data received"
        case .statusCode(let statusCode):
            errorMessage = "Status code: \(statusCode)"
        case .decodeError(let decodableName):
            errorMessage = "Could not decode data to \(decodableName)"
        case .noInternet:
            errorMessage = "Please check your internet connection"
        }
        os_log("%@",type: .error, errorMessage)
        return errorMessage
    }
}

enum HTTPStatusCode: Int {
    case success = 200
}
