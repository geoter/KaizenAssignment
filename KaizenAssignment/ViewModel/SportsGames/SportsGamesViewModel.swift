//
//  SportsGamesViewModel.swift
//  KaizenAssignment
//
//  Created by George Termentzoglou on 10/9/22.
//

import Foundation
import Combine

protocol SportsGamesViewModelProtocol: AnyObject {
    var state: State<[BinderModelConformer]> { get }
    func fetchGames()
    init(network: NetworkProtocol, dataFactory: SportsGamesDataFactoryProtocol)
}

final class SportsGamesViewModel: SportsGamesViewModelProtocol {
    @Published private(set) var state: State<[BinderModelConformer]> = .loading
    
    //MARK: - Private variables
    private let network: NetworkProtocol
    private let dataFactory: SportsGamesDataFactoryProtocol
    
    //MARK: - Public
    
    init(network: NetworkProtocol, dataFactory: SportsGamesDataFactoryProtocol) {
        self.network = network
        self.dataFactory = dataFactory
    }
    
    func fetchGames() {
        let request = SportsRequest()
        self.network.sendRequest(request: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.processResponse(models: response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - Private
    
    private func processResponse(models: [SportModel]) {
        let binders = dataFactory.makeBinders(from: models)
        state = .loaded(binders)
    }
}
