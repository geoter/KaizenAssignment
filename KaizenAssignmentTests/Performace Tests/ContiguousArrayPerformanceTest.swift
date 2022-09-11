//
//  ContiguousArrayPerformanceTest.swift
//  KaizenAssignmentTests
//
//  Created by George Termentzoglou on 11/9/22.
//

import XCTest
@testable import KaizenAssignment

/// These Tests where created to test a speed of an alternative implementation of 'SportsGamesDataFactory' 'makeBinders' method, that would use ContiguousArray for better memory allocation. The results show ContiguousArray is faster and should be considered as an alternative
final class ContiguousArrayPerformanceTest: XCTestCase {
    var models: [SportModel]?
    
    override func setUpWithError() throws {
        let event = SportEvent(eventId: "1", sportId: "22", eventName: "Event name", eventStartTimestamp: 1111111)
        let model = SportModel(sportId: "2", sportName: "Test", events: [event])
        models = [model]
        models = models! * 1000
    }
    
    func makeBinders(from models: [SportModel]?) -> [BinderModelConformer] {
        var binderModels = [BinderModelConformer]()
        models?.forEach { model in
            //Header
            let headerBinderModel = SportHeaderBinderModel(sportID: model.sportId,
                                                           sportName: model.sportName,
                                                           sportIconName: model.sportId,
                                                           isCollapsed: false)
            binderModels.append(headerBinderModel)
            //Events
            ///show Favorites first in the list
            var normalBinderModels: [SportEventBinderModel] = []
            model.events.forEach { event in
                let binderModel = SportEventBinderModel(eventID: event.eventId, sportID: event.sportId, caption: event.eventName, eventStartTimestamp: event.eventStartTimestamp, isFavorite: true)
                normalBinderModels.append(binderModel)
            }
            let sportEventsBinderModels = SportEventsBinderModel(sportID: model.sportId, events: normalBinderModels)
            binderModels.append(sportEventsBinderModels)
        }
        return binderModels
    }
    
    func makeBinders(from models: [SportModel]?) -> ContiguousArray<BinderModelConformer> {
        var binderModels = ContiguousArray<BinderModelConformer>()
        models?.forEach { model in
            //Header
            let headerBinderModel = SportHeaderBinderModel(sportID: model.sportId,
                                                           sportName: model.sportName,
                                                           sportIconName: model.sportId,
                                                           isCollapsed: false)
            binderModels.append(headerBinderModel)
            //Events
            ///show Favorites first in the list
            var normalBinderModels: [SportEventBinderModel] = []
            model.events.forEach { event in
                let binderModel = SportEventBinderModel(eventID: event.eventId, sportID: event.sportId, caption: event.eventName, eventStartTimestamp: event.eventStartTimestamp, isFavorite: true)
                normalBinderModels.append(binderModel)
            }
            let sportEventsBinderModels = SportEventsBinderModel(sportID: model.sportId, events: normalBinderModels)
            binderModels.append(sportEventsBinderModels)
        }
        return binderModels
    }
    
    func testArraySpeed() throws {
        // This is an example of a performance test case.
        self.measure {
            let binders: Array = makeBinders(from: self.models)
        }
    }
    
    func testContiguousArraySpeed() throws {
        // This is an example of a performance test case.
        self.measure {
            let binders: ContiguousArray = makeBinders(from: self.models)
        }
    }

}
