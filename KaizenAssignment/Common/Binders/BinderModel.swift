//
//  BinderModel.swift
//  KaizenAssignment
//
//  Created by George Termentzoglou on 10/9/22.
//

import Foundation
import UIKit

protocol BinderModelConformer {
    func rowHeight() -> CGFloat
    func getCellType() -> BinderCellType
}

extension BinderModelConformer {
    func rowHeight() -> CGFloat {
        UITableView.automaticDimension
    }
}
