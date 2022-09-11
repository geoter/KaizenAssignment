//
//  ArrayExtensions.swift
//  KaizenAssignmentTests
//
//  Created by George Termentzoglou on 11/9/22.
//

import Foundation

extension Array {
    
    /// Can be used in Unit tests to provide large data sets (e.g. for performance testing)
    static func *(lhs: Array, rhs: Int) -> Array {
        var tempArray = Array()
        tempArray.reserveCapacity(lhs.count * rhs)
        for _ in 1...rhs {
            tempArray.append(contentsOf: lhs)
        }
        return tempArray
    }
}
