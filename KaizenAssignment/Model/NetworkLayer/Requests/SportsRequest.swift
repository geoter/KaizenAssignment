//
//  SportsRequest.swift
//  KaizenAssignment
//
//  Created by George Termentzoglou on 10/9/22.
//

import Foundation

struct SportsRequest: Requestable {
    typealias ResponseType = [SportModel]
    var path: String { "/api/sports" }
    var method: RequestMethod { .GET }
}
