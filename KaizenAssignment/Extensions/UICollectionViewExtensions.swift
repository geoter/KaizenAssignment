//
//  UICollectionViewExtensions.swift
//  KaizenAssignment
//
//  Created by George Termentzoglou on 11/9/22.
//

import Foundation
import UIKit

protocol CollectionViewCellReusable {
    static var cellIdentifier: String { get }
    static var nibIdentifier: String { get }
}

extension UICollectionViewCell: CollectionViewCellReusable {
    static var cellIdentifier: String { return String("\(self)Identifier") }
    static var nibIdentifier: String { return String(describing: Self.self) }
}
