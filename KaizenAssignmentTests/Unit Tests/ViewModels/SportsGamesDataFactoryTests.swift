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

}
