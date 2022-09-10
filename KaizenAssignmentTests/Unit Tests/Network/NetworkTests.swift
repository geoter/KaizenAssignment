//
//  NetworkTests.swift
//  KaizenAssignmentTests
//
//  Created by George Termentzoglou on 10/9/22.
//

import XCTest
@testable import KaizenAssignment
import Network

class NetworkTests: XCTestCase {

    func testResponseSuccessReceive() throws {
        let jsonData: Data = FileReader().read(from: "sports_response.json")!
        let network = NetworkMock(stubResponse: jsonData)
        let request = SportsRequest()
        
        network.sendRequest(request: request) { result in
            guard case let .success(sports) = result else {
                XCTFail("NetworkMock request failed")
                return
            }
            XCTAssertEqual(sports.count, 9)
        }
    }
    
    func testResponseDecodeError() throws {
        let jsonData: Data = FileReader().read(from: "sports_response_malformed.json")!
        let network = NetworkMock(stubResponse: jsonData)
        let request = SportsRequest()
        
        network.sendRequest(request: request) { result in
            guard case let .failure(error) = result else {
                XCTFail("NetworkMock response is not malformed")
                return
            }
            guard case let .decodeError(_) = error else {
                XCTFail("NetworkMock decoding is broken")
                return
            }
        }
    }
    
    func testNoInternetErrorSuccess() {
        let reachability = ReachabilityMock(hasInternet: false)
        let config = NetworkConfig(scheme: "https", host: "618d3aa7fe09aa001744060a.mockapi.io",
                                   reachability: reachability, session: .shared)
        let network = Network(config:config)
        let request = SportsRequest()
        
        let expectation = XCTestExpectation(description: "Network request: No internet")
        
        network.sendRequest(request: request) { result in
            defer { expectation.fulfill() }
            guard case let .failure(error) = result else {
                XCTFail("Request should have failed")
                return
            }
            guard case let .noInternet = error else {
                XCTFail("No internet check not working")
                return
            }
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testInvalidURLPath() throws {
        let network = Network.shared
        let request = InvalidPathRequest()
        let expectation = XCTestExpectation(description: "Network request: Invalid Path")
        
        network.sendRequest(request: request) { result in
            defer { expectation.fulfill() }
            guard case let .failure(error) = result else {
                XCTFail("Invalid URL Path request should have failed")
                return
            }
            guard case let .invalidPath(_) = error else {
                XCTFail("Invalid URL Path not detected, when it should have")
                return
            }
        }
        wait(for: [expectation], timeout: 3.0)
    }
}
