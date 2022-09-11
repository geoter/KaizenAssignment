//
//  BinderDataSource.swift
//  KaizenAssignment
//
//  Created by George Termentzoglou on 10/9/22.
//

import Foundation
import UIKit

typealias CellInstanceData = (cell: UITableViewCell, indexPath: IndexPath)

protocol BinderDataSourceDelegate: AnyObject {
    func binderDatasource(_ tableView: UITableView, cellCreated: CellInstanceData)
    func binderDataSource(_ tableView: UITableView, didSelect model: BinderModelConformer)
}

final class BinderDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    weak var binderDelegate: BinderDataSourceDelegate?
    
    private var dataList: [BinderModelConformer] = []
    private var binders: [BinderCellType] = []
    
    init(with models: [BinderModelConformer]) {
        super.init()
        self.dataList = models
        self.binders = models.map{ $0.getCellType() }
    }
    
    func bind(to tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
        registerNibs(tableView: tableView)
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return dataList[indexPath.row].rowHeight()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = computeCell(tableView: tableView, indexPath: indexPath)
        cell.setup(with: dataList[indexPath.row])
        binderDelegate?.binderDatasource(tableView, cellCreated: (cell, indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < dataList.count else { return }
        binderDelegate?.binderDataSource(tableView, didSelect: dataList[indexPath.row])
    }
    
    // MARK:  Private Methods

    private func registerNibs(tableView: UITableView) {
        self.binders.forEach { cellType in
            tableView.register(UINib(nibName: cellType.nibName, bundle: nil), forCellReuseIdentifier: cellType.identifier)
        }
    }
    
    private func computeCell(tableView: UITableView, indexPath: IndexPath) -> BinderCell {
        guard indexPath.row < dataList.count else { return BinderCell() } //TODO: create EmptyCell to show in this case
        let cellIdentifier = dataList[indexPath.row].getCellType().identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BinderCell
        return cell
    }
    
}
