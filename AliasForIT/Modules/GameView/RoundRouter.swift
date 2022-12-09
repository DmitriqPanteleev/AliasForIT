//
//  RoundRouter.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 15.11.2022.
//

import Foundation

protocol RoundRouter: AnyObject {
    func moveToRound(model: RoundModel)
    func moveToFinish(answeredWords: [AnswerModel])
    func pop(sendScore: @escaping () -> Void)
}

extension RoundCoordinator: RoundRouter {
    func moveToRound(model: RoundModel) {
        self.route(to: \.round, model)
    }
    
    func moveToFinish(answeredWords: [AnswerModel]) {
        self.route(to: \.finish, answeredWords)
    }
    
    func pop(sendScore: @escaping () -> Void) {
        self.popToRoot({
            sendScore()
        })
    }
}
