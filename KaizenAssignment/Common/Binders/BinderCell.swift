//
//  BinderCell.swift
//  KaizenAssignment
//
//  Created by George Termentzoglou on 10/9/22.
//

import Foundation
import UIKit

protocol BinderCellConformer where Self: UITableViewCell {
    static var type: String { get }
    func setup(with data: BinderModelConformer)
}

struct BinderCellType {
    let cellType: String
    let identifier: String
    let nibName: String
    init(_ cell: BinderCell.Type){
        cellType = cell.type
        identifier = cell.cellIdentifier
        nibName = cell.nibIdentifier
    }
}

class BinderCell: UITableViewCell, BinderCellConformer {
    func setup(with data: BinderModelConformer) {}
    static var type: String {
        return String(describing: Self.self)
    }
}
