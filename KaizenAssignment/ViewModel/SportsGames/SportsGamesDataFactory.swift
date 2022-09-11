//
//  SportsGamesDataFactory.swift
//  KaizenAssignment
//
//  Created by George Termentzoglou on 10/9/22.
//

import Foundation

protocol SportsGamesDataFactoryProtocol {
    func makeBinders(from models: [SportModel]?) -> [BinderModelConformer]
    func toggleCollapse(for model: SportHeaderBinderModel)
    func isCollapsed(model: SportHeaderBinderModel) -> Bool
}

final class SportsGamesDataFactory: SportsGamesDataFactoryProtocol {
    private var collapsedSports = Set<String>()
    
    func makeBinders(from models: [SportModel]?) -> [BinderModelConformer] {
        var binderModels = [BinderModelConformer]()
        models?.forEach { model in
            //Header
            let isCollapsed = collapsedSports.contains(model.sportId)
            let headerBinderModel = SportHeaderBinderModel(sportID: model.sportId,
                                                           sportName: model.sportName,
                                                           sportIconName: model.sportId,
                                                           isCollapsed: isCollapsed)
            binderModels.append(headerBinderModel)
            guard isCollapsed == false else { return }
            //Events
            let eventBindelModels = model.events.map { event in
                SportEventBinderModel(eventID: event.eventId, sportID: event.sportId, caption: event.eventName, eventStartTimestamp: event.eventStartTimestamp)
            }
            let sportEventsBinderModels = SportEventsBinderModel(events: eventBindelModels)
            binderModels.append(sportEventsBinderModels)
        }
        return binderModels
    }
}

//MARK: - Expand Collapse

extension SportsGamesDataFactory {
    func toggleCollapse(for model: SportHeaderBinderModel) {
        guard collapsedSports.contains(model.sportID) else {
            collapsedSports.insert(model.sportID)
            return
        }
        collapsedSports.remove(model.sportID)
    }
    
    func isCollapsed(model: SportHeaderBinderModel) -> Bool {
        collapsedSports.contains(model.sportID)
    }
}
