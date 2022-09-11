//
//  SportEventsViewController.swift
//  KaizenAssignment
//
//  Created by George Termentzoglou on 11/9/22.
//

import UIKit

final class SportEventsViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var loadingView: UIStackView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    private var viewModel: SportsGamesViewModel!
    private var binderDatasource: BinderDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SportsGamesViewModel(network: Network.shared, dataFactory: SportsGamesDataFactory())
        viewModel.delegate = self
        viewModel.fetchGames()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }
}

extension SportEventsViewController: SportsGamesViewModelDelegate {
    func sportsGamesViewModel(changed state: State<[BinderModelConformer]>) {
        switch state {
        case .loading:
            loadingView.isHidden = false
            activityIndicator.startAnimating()
        case .loaded(let binderModels):
            loadingView.isHidden = true
            activityIndicator.stopAnimating()
            binderDatasource = BinderDataSource(with: binderModels)
            binderDatasource!.binderDelegate = self
            binderDatasource!.bind(to: tableView)
        case .error:
            return
        }
    }
}

extension SportEventsViewController: BinderDataSourceDelegate {
    func binderDatasource(_ tableView: UITableView, cellCreated: CellInstanceData) {
        switch cellCreated.cell {
        case let cell as SportEventsTableViewCell:
            cell.delegate = self
        default: return
        }
    }
    
    func binderDataSource(_ tableView: UITableView, didSelect model: BinderModelConformer) {
        guard let headerModel = model as? SportHeaderBinderModel else { return }
        viewModel.toggleCollapse(for: headerModel)
    }
}

extension SportEventsViewController: SportEventsTableViewCellDelegate {
    func sportEventsFavoriteToggle(eventID: String) {
        viewModel.toggleFavorite(for: eventID)
    }
}
