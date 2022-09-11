//
//  Assets.swift
//  KaizenAssignment
//
//  Created by George Termentzoglou on 11/9/22.
//

import Foundation
import UIKit

enum Assets {
    enum SportsIcons: String {
        case basketball = "BASK"
        case soccer = "FOOT"
        case tennis = "TENN"
        case tableTennis = "TABL"
        case volleyball = "VOLL"
    }
    
    static var expandIcon: UIImage? {
        UIImage(named: "arrow-down-template")
    }
    
    static var collapseIcon: UIImage? {
        UIImage(named: "arrow-up-template")
    }
    
    static func icon(for sport: String) -> UIImage? {
        var iconImage: String!
        switch SportsIcons(rawValue: sport) {
        case .basketball:
            iconImage = "Basketball"
        case .soccer:
            iconImage = "Football"
        case .tableTennis:
            iconImage = "table_tennis"
        case .volleyball:
            iconImage = "Volley"
        case .tennis:
            iconImage = "Tennis"
        default:
            iconImage = "Generic"
        }
        return UIImage(named: iconImage)
    }
}
