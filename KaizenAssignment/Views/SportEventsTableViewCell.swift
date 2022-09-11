//
//  SportEventsTableViewCell.swift
//  KaizenAssignment
//
//  Created by George Termentzoglou on 11/9/22.
//

import UIKit

final class SportEventsTableViewCell: BinderCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func setup(with data: BinderModelConformer) {
        guard let model = data as? SportEventsBinderModel else { return }
    }
}
