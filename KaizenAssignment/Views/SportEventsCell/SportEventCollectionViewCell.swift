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
    
    @IBOutlet private var timeLabel: CountDownLabel!
    @IBOutlet private var homeTeamLabel: UILabel!
    @IBOutlet private var awayTeamLabel: UILabel!
    @IBOutlet private var favoriteButton: UIButton!
    @IBOutlet private var containerView: UIView!
    private var model: SportEventBinderModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.rounded()
        timeLabel.rounded()
        timeLabel.textAlignment = .center
        timeLabel.textEdgeInsets = .init(top: 3, left: 8, bottom: 3, right: 8)
        timeLabel.backgroundColor = .lightGray.withAlphaComponent(0.2)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        timeLabel.stop()
    }
    
    func setup(with model: SportEventBinderModel) {
        self.model = model
        homeTeamLabel.text = model.homeCompetitor
        awayTeamLabel.text = model.awayCompetitor
        favoriteButton.setBackgroundImage(model.isFavorite ? Assets.starFilledIcon : Assets.starEmptyIcon, for: .normal)
        timeLabel.setup(with: model.eventStartTimestamp)
        timeLabel.start()
    }

    @IBAction private func favoritedTapped(_ sender: Any) {
        guard let binderModel = self.model else { return }
        delegate?.sportEventFavoriteToggle(model: binderModel)
    }
}
