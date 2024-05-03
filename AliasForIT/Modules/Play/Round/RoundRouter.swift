//
//  RoundRouter.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 15.11.2022.
//

import Foundation

protocol RoundRouter: AnyObject {
    func pop(with score: Int)
}

extension GameCoordinator: RoundRouter {
    func pop(with score: Int) {
        defer { onRoundFinish.send(score) }
        self.popToRoot()
    }
}
