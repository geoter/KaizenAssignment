//
//  UITableViewExtensions.swift
//  KaizenAssignment
//
//  Created by George Termentzoglou on 10/9/22.
//

import Foundation
import UIKit

protocol TableViewCellReusable {
    static var cellIdentifier: String { get }
    static var nibIdentifier: String { get }
}

extension UITableViewCell: TableViewCellReusable {
    static var cellIdentifier: String { return String("\(self)Identifier") }
    static var nibIdentifier: String { return String(describing: Self.self) }
}
