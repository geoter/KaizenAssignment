//
//  SportsGamesViewModel.swift
//  KaizenAssignment
//
//  Created by George Termentzoglou on 10/9/22.
//

import Foundation


final class SportsGamesViewModel {
    private let network: NetworkProtocol
    private let dataFactory: SportsGamesDataFactoryProtocol
    
    init(network: NetworkProtocol, dataFactory: SportsGamesDataFactoryProtocol) {
        self.network = network
        self.dataFactory = dataFactory
    }
    
    func fetchGames() {
        let request = SportsRequest()
        self.network.sendRequest(request: request) { result in
            switch result {
            case .success(let response):
                print(response.first)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
