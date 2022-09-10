//
//  ReachabilityMock.swift
//  KaizenAssignmentTests
//
//  Created by George Termentzoglou on 10/9/22.
//

import Foundation
@testable import KaizenAssignment

final class ReachabilityMock: Reachability {
    private let hasInternet: Bool
    
    init(hasInternet: Bool) {
        self.hasInternet = hasInternet
    }
    override var hasInternetConnection: Bool {
        return hasInternet
    }
}
