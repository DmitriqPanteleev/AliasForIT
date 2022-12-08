//
//  RoundRouter.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 15.11.2022.
//

import Foundation

protocol RoundRouter: AnyObject {
    func moveToRound(model: RoundModel)
    func pop()
}

extension RoundCoordinator: RoundRouter {
    func moveToRound(model: RoundModel) {
        self.route(to: \.round, model)
    }
    
    func pop() {
        self.popToRoot()
    }
}
