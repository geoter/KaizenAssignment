//
//  SportsGamesViewModel_IntegrationTests.swift
//  KaizenAssignmentTests
//
//  Created by George Termentzoglou on 11/9/22.
//

import XCTest
@testable import KaizenAssignment

class SportsGamesViewModel_IntegrationTests: XCTestCase {
    var viewModel: SportsGamesViewModel!
    var dataFactory: SportsGamesDataFactory!
    
    override func setUpWithError() throws {
        let jsonData: Data = FileReader().read(from: "sports_response.json")!
        let network = NetworkMock(stubResponse: jsonData)
        dataFactory = SportsGamesDataFactory()
        viewModel = SportsGamesViewModel(network: network, dataFactory: dataFactory)
    }

    func testSportsGamesBinderModelsCreation() throws {
        viewModel.fetchGames()
        if case let .loaded(binderModels) = viewModel.state {
            XCTAssertEqual(binderModels.count, 18)
        }
    }
    
    func testCollapse() throws {
        viewModel.fetchGames()
        let model = SportHeaderBinderModel(sportID: "BASK", sportName: "BASKETBALL", sportIconName: "BASK", isCollapsed: false)
        viewModel.toggleCollapse(for: model)
        if case let .loaded(binderModels) = viewModel.state {
            XCTAssertEqual(binderModels.count, 17, "Collapse did not work")
        }
        viewModel.toggleCollapse(for: model)
        if case let .loaded(binderModels) = viewModel.state {
            XCTAssertEqual(binderModels.count, 18, "Expand did not work")
        }
    }
}
