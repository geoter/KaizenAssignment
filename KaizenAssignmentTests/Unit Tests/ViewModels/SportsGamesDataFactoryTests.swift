//
//  SportsGamesDataFactoryTests.swift
//  KaizenAssignmentTests
//
//  Created by George Termentzoglou on 11/9/22.
//

import XCTest
@testable import KaizenAssignment

class SportsGamesDataFactoryTests: XCTestCase {
    var dataFactory: SportsGamesDataFactory!
    
    override func setUpWithError() throws {
        dataFactory = SportsGamesDataFactory()
    }
    
    func testCollapse() throws {
        let model = SportHeaderBinderModel(sportID: "BASK", sportName: "BASKETBALL", sportIconName: "BASK", isCollapsed: false)
        dataFactory.toggleCollapse(for: model)
        XCTAssertTrue(dataFactory.isCollapsed(model: model), "Collapse did not work")
        dataFactory.toggleCollapse(for: model)
        XCTAssertFalse(dataFactory.isCollapsed(model: model), "Expand did not work")
    }
    
    func testFavorites() throws {
        let model = SportHeaderBinderModel(sportID: "BASK", sportName: "BASKETBALL", sportIconName: "BASK", isCollapsed: false)
        dataFactory.toggleFavorites(for: model.sportID)
        XCTAssertTrue(dataFactory.isFavorite(eventID: model.sportID), "Favorites add did not work")
        dataFactory.toggleFavorites(for: model.sportID)
        XCTAssertFalse(dataFactory.isFavorite(eventID: model.sportID), "Favorites remove did not work")
    }

}
