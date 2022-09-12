//
//  SportEventsBinderModel.swift
//  KaizenAssignment
//
//  Created by George Termentzoglou on 11/9/22.
//

import Foundation

struct SportEventsBinderModel {
    let sportID: String
    let events: [SportEventBinderModel]
}

struct SportEventBinderModel {
    let eventID: String
    let sportID: String
    let caption: String
    let eventStartTimestamp: Int
    let isFavorite: Bool
    
    var homeCompetitor: String? {
        caption.components(separatedBy: "-").first?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var awayCompetitor: String? {
        caption.components(separatedBy: "-").last?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

extension SportEventsBinderModel: BinderModelConformer {
    func getCellType() -> BinderCellType {
        BinderCellType(SportEventsTableViewCell.self, uniqueIdentifier: sportID)
    }
}
