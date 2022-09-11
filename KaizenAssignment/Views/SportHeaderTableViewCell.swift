//
//  SportHeaderTableViewCell.swift
//  KaizenAssignment
//
//  Created by George Termentzoglou on 11/9/22.
//

import UIKit

final class SportHeaderTableViewCell: BinderCell {
    @IBOutlet private weak var expandCollapseIcon: UIImageView!
    @IBOutlet private weak var sportName: UILabel!
    @IBOutlet private weak var sportsIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func setup(with data: BinderModelConformer) {
        guard let model = data as? SportHeaderBinderModel else { return }
        expandCollapseIcon.image = model.isCollapsed ? Assets.collapseIcon : Assets.expandIcon
        sportName.text = model.sportName
        sportsIcon.image = Assets.icon(for: model.sportIconName)
    }
}
