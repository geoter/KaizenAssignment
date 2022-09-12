//
//  KaizenAssignmentUITests.swift
//  KaizenAssignmentUITests
//
//  Created by George Termentzoglou on 10/9/22.
//

import XCTest

class KaizenAssignmentUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app = XCUIApplication()
    }
    
    override func tearDownWithError() throws {
        app.launchArguments = []
    }

    func testNavigationItemsExist() throws {
        let stoiximanNavigationBar = app.navigationBars["Stoiximan"]
        XCTAssertTrue(stoiximanNavigationBar.buttons["user template"].exists)
        XCTAssertTrue(stoiximanNavigationBar.buttons["settings template"].exists)
    }
    
    func testLoadingIsVisible() throws {
        app.launch()
        XCTAssertEqual(app.activityIndicators.count, 1)
    }
    
    func testTableViewCellsExist() {
        app.launchArguments = [EnvArgs.NetworkMock]
        app.launch()
        let cellExists = app.tables.cells.element(matching: .cell, identifier: "SportHeaderTableViewCell").waitForExistence(timeout: 1)
        XCTAssertTrue(cellExists, "Tableview results did not appear for 5 seconds")
        let headersCount = app.tables.children(matching: .cell).count
        XCTAssertEqual(headersCount, 18)
    }
}
