//
//  UIViewExtension.swift
//  KaizenAssignment
//
//  Created by George Termentzoglou on 11/9/22.
//

import Foundation
import UIKit

extension UIView {
    func rounded(cornerRadius: CGFloat = 4.0) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMinXMaxYCorner ,.layerMaxXMaxYCorner]
    }
    
    func bordered(color: UIColor = UIColor.white, borderWidth: CGFloat = 1.0) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = borderWidth
    }
}
