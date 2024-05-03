//
//  GameRouter.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 02.05.2024.
//

import Foundation

protocol GameRouter: AnyObject {
    func moveToRound(model: RoundModel)
    func exit()
}

extension GameCoordinator: GameRouter {
    func moveToRound(model: RoundModel) {
        self.route(to: \.round, model)
    }
    
    func exit() {
        self.dismissCoordinator()
    }
}
