//
//  SportEventCollectionViewCell.swift
//  KaizenAssignment
//
//  Created by George Termentzoglou on 11/9/22.
//

import UIKit

protocol SportEventCollectionViewCellDelegate: AnyObject {
    func sportEventFavoriteToggle(model: SportEventBinderModel)
}

final class SportEventCollectionViewCell: UICollectionViewCell {
    weak var delegate: SportEventCollectionViewCellDelegate?
    
    @IBOutlet private var timeLabel: UILabel!
    @IBOutlet private var homeTeamLabel: UILabel!
    @IBOutlet private var awayTeamLabel: UILabel!
    private var model: SportEventBinderModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(with model: SportEventBinderModel) {
        self.model = model
        homeTeamLabel.text = model.homeCompetitor
        awayTeamLabel.text = model.awayCompetitor
        timeLabel.text = String(model.eventStartTimestamp) //TODO: make CountDownLabel
    }

    @IBAction private func favoritedTapped(_ sender: Any) {
        guard let binderModel = self.model else { return }
        delegate?.sportEventFavoriteToggle(model: binderModel)
    }
}
