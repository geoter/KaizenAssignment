//
//  SportEventsTableViewCell.swift
//  KaizenAssignment
//
//  Created by George Termentzoglou on 11/9/22.
//

import UIKit

final class SportEventsTableViewCell: BinderCell {
    @IBOutlet private var gamesCollectionView: UICollectionView!
    private var binderModel: SportEventsBinderModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        setupCollectionView()
    }
    
    private var events: [SportEventBinderModel] {
        binderModel?.events ?? []
    }
    
    override func setup(with data: BinderModelConformer) {
        guard let model = data as? SportEventsBinderModel else { return }
        binderModel = model
        gamesCollectionView.reloadData()
    }
    
    private func setupCollectionView() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumInteritemSpacing = 4.0
        collectionViewLayout.minimumLineSpacing = 4.0
        collectionViewLayout.estimatedItemSize = CGSize(width: 100, height: 150)
        collectionViewLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 8, bottom: 0, right: 8)
        gamesCollectionView.collectionViewLayout = collectionViewLayout
        gamesCollectionView.delegate = self
        gamesCollectionView.dataSource = self
        gamesCollectionView.register(UINib(nibName: SportEventCollectionViewCell.nibIdentifier, bundle: nil), forCellWithReuseIdentifier: SportEventCollectionViewCell.cellIdentifier)
    }
}

extension SportEventsTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return binderModel?.events.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SportEventCollectionViewCell.cellIdentifier, for: indexPath) as! SportEventCollectionViewCell
        guard indexPath.row < events.count else { return cell }
        cell.setup(with:events[indexPath.row])
       return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
