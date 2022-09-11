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
    func toggleFavorites(for eventID: String)
    func isFavorite(eventID: String) -> Bool
}

final class SportsGamesDataFactory: SportsGamesDataFactoryProtocol {
    private var collapsedSports = Set<String>()
    private var favoriteEvents = Set<String>()
    
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
            ///show Favorites first in the list
            var favoriteBinderModels: [SportEventBinderModel] = []
            var normalBinderModels: [SportEventBinderModel] = []
            model.events.forEach { event in
                let isFavorite = isFavorite(eventID: event.eventId)
                let binderModel = SportEventBinderModel(eventID: event.eventId, sportID: event.sportId, caption: event.eventName, eventStartTimestamp: event.eventStartTimestamp, isFavorite: isFavorite)
                guard isFavorite else {
                    normalBinderModels.append(binderModel)
                    return
                }
                favoriteBinderModels.append(binderModel)
            }
            var totalModels = [SportEventBinderModel]()
            totalModels.reserveCapacity(favoriteBinderModels.count + normalBinderModels.count)
            totalModels.append(contentsOf: favoriteBinderModels)
            totalModels.append(contentsOf: normalBinderModels)
            let sportEventsBinderModels = SportEventsBinderModel(sportID: model.sportId, events: totalModels)
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

//MARK: - Favorites

extension SportsGamesDataFactory {
    func toggleFavorites(for eventID: String) {
        guard favoriteEvents.contains(eventID) else {
            favoriteEvents.insert(eventID)
            return
        }
        favoriteEvents.remove(eventID)
    }
    
    func isFavorite(eventID: String) -> Bool {
        favoriteEvents.contains(eventID)
    }
}
