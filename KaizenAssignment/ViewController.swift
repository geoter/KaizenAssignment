//
//  ViewController.swift
//  KaizenAssignment
//
//  Created by George Termentzoglou on 10/9/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let request = SportsRequest()
        Network.shared.sendRequest(request: request) { result in
            switch result {
            case .success(let response):
                print(response.first)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }


}

