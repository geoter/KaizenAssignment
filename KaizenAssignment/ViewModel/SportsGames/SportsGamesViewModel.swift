//
//  SportsGamesViewModel.swift
//  KaizenAssignment
//
//  Created by George Termentzoglou on 10/9/22.
//

import Foundation

protocol SportsGamesViewModelProtocol {
    var state: State<[BinderModelConformer]> { get }
    var delegate: SportsGamesViewModelDelegate? { get set }
    func fetchGames()
    init(network: NetworkProtocol, dataFactory: SportsGamesDataFactoryProtocol)
}

protocol SportsGamesViewModelDelegate: AnyObject {
    func sportsGamesViewModel(changed state: State<[BinderModelConformer]>)
}

final class SportsGamesViewModel: SportsGamesViewModelProtocol {
    weak var delegate: SportsGamesViewModelDelegate?
    private(set) var state: State<[BinderModelConformer]> = .loading {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.delegate?.sportsGamesViewModel(changed: self.state)
            }
        }
    }
    
    //MARK: - Private variables
    private let network: NetworkProtocol
    private let dataFactory: SportsGamesDataFactoryProtocol
    private var models: [SportModel]?
    //MARK: - Public
    
    init(network: NetworkProtocol, dataFactory: SportsGamesDataFactoryProtocol) {
        self.network = network
        self.dataFactory = dataFactory
    }
    
    func fetchGames() {
        state = .loading
        let request = SportsRequest()
        self.network.sendRequest(request: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.processResponse(models: response)
            case .failure(let error):
                self.state = .error
                print(error.localizedDescription)
            }
        }
    }
    
    func toggleCollapse(for model: SportHeaderBinderModel) {
        dataFactory.toggleCollapse(for: model)
        let binders = dataFactory.makeBinders(from: self.models)
        state = .loaded(binders)
    }
    
    //MARK: - Private
    
    private func processResponse(models: [SportModel]) {
        self.models = models
        let binders = dataFactory.makeBinders(from: models)
        state = .loaded(binders)
    }
}
