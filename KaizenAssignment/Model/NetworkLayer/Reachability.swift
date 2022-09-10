//
//  Reachability.swift
//  KaizenAssignment
//
//  Created by George Termentzoglou on 10/9/22.
//

import Foundation
import Network

class Reachability {
    static let shared = Reachability()
    private let monitor = NWPathMonitor()
    private let queue: DispatchQueue!
    private var _hasInternetConnection: Bool?
    
    var hasInternetConnection: Bool {
        _hasInternetConnection ?? true ///default to true to allow requests in case something failed in Reachability
    }
    
    init() {
        queue = DispatchQueue(label: "Reachability")
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            self._hasInternetConnection = path.status == .satisfied
        }
        monitor.start(queue: queue)
    }
    
    deinit {
        monitor.cancel()
    }
}

