//
//  UINavigationControllerExtension.swift
//  KaizenAssignment
//
//  Created by George Termentzoglou on 11/9/22.
//

import Foundation
import UIKit


extension UIViewController {
    func setupNavBar() {
        self.navigationItem.leftBarButtonItem = .profile()
        self.navigationItem.rightBarButtonItem = .login()
        self.navigationItem.titleView = UIImageView(image: .init(named: "kaizen-logo"))
    }
}

extension UIBarButtonItem {
    class func profile() -> UIBarButtonItem {
        let width = 25.0
        let button = UIButton(type: UIButton.ButtonType.custom) as UIButton
        button.frame = CGRect(x: 0, y: 0, width: width, height: width)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: button.frame.size.width).isActive = true
        button.heightAnchor.constraint(equalToConstant: width).isActive = true
        button.imageView!.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .leading
        button.setImage(.init(named: "user-template"), for: .normal)
        button.tintColor = .color(hex: "0066cc")
        return UIBarButtonItem(customView: button)
    }

    class func login() -> UIBarButtonItem {
        let width = 25.0
        let button = UIButton(type: UIButton.ButtonType.custom) as UIButton
        button.frame = CGRect(x: 0, y: 0, width: width, height: width)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: button.frame.size.width).isActive = true
        button.heightAnchor.constraint(equalToConstant: width).isActive = true
        button.imageView!.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .leading
        button.setImage(.init(named: "settings-template"), for: .normal)
        button.tintColor = .color(hex: "0066cc")
        return UIBarButtonItem(customView: button)
    }
}

