//
//  SportsGamesDataFactory.swift
//  KaizenAssignment
//
//  Created by George Termentzoglou on 10/9/22.
//

import Foundation

protocol SportsGamesDataFactoryProtocol {
    func makeBinders(from models: [SportModel]) -> [BinderModelConformer]
}

final class SportsGamesDataFactory: SportsGamesDataFactoryProtocol {
    func makeBinders(from models: [SportModel]) -> [BinderModelConformer] {
        []
    }
}
