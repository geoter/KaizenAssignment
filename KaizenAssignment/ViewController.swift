//
//  ViewController.swift
//  KaizenAssignment
//
//  Created by George Termentzoglou on 10/9/22.
//

import UIKit

class ViewController: UIViewController {
    private var viewModel: SportsGamesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchGames()
    }
}

