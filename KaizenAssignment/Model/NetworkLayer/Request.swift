//
//  Request.swift
//  KaizenAssignment
//
//  Created by George Termentzoglou on 10/9/22.
//

import Foundation

protocol Requestable {
    associatedtype ResponseType: Decodable
    var path: String { get }
    var method: RequestMethod { get }
}

enum RequestMethod: String {
    case GET
}
