//
//  State.swift
//  KaizenAssignment
//
//  Created by George Termentzoglou on 10/9/22.
//

import Foundation

enum State<T> {
    case loading
    case loaded(T)
    case error
}
