//
//  MainRouter.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 12.12.2022.
//

import Foundation
import Stinsen

protocol MainRouter: AnyObject {
    func moveToGame(teams: [TeamModel])
    func moveToRules()
    func moveToSettings()
    func pop(action: @escaping () -> Void)
}

extension MainCoordinator: MainRouter {
    
    func moveToGame(teams: [TeamModel]) {
        self.route(to: \.game, teams)
    }
    
    func moveToRules() {
        //TODO:
    }
    
    func moveToSettings() {
        self.route(to: \.settings)
    }
    
    func pop(action: @escaping () -> Void) {
        self.popToRoot(action)
    }
    
}
