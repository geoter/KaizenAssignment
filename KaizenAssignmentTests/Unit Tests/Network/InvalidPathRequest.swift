//
//  InvalidPathRequest.swift
//  KaizenAssignmentTests
//
//  Created by George Termentzoglou on 10/9/22.
//

import Foundation
@testable import KaizenAssignment

struct InvalidPathRequest: Requestable {
    typealias ResponseType = [SportModel]
    var path: String { "api/sports" }
    var method: RequestMethod { .GET }
}
