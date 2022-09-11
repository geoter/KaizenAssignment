//
//  SportHeaderBinderModel.swift
//  KaizenAssignment
//
//  Created by George Termentzoglou on 11/9/22.
//

import Foundation

struct SportHeaderBinderModel {
    let sportID: String
    let sportName: String
    let sportIconName: String
    let isCollapsed: Bool
}

extension SportHeaderBinderModel: BinderModelConformer {
    func getCellType() -> BinderCellType {
        BinderCellType(SportHeaderTableViewCell.self)
    }
}

