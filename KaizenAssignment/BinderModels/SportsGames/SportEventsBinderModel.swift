//
//  SportEventsBinderModel.swift
//  KaizenAssignment
//
//  Created by George Termentzoglou on 11/9/22.
//

import Foundation

struct SportEventsBinderModel {
    
}

extension SportEventsBinderModel: BinderModelConformer {
    func getCellType() -> BinderCellType {
        BinderCellType(SportEventsTableViewCell.self)
    }
}
