//
//  RoundCoordinator.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 08.12.2022.
//

import SwiftUI
import Combine
import Stinsen

final class RoundCoordinator: NavigationCoordinatable {
    
    // TODO: переделать навигацию, хранить переменную о начатой игре,
    // в зависимости от нее менять Root навигатора и после конца игры очищать
    // для этого сделать провайдер в FinishedRoundView, переделать логику Route
    var stack = Stinsen.NavigationStack<RoundCoordinator>(initial: \.game)
    
    @Root var game = makeGame
    
    @Route(.fullScreen) var round = makeRound
    @Route(.push) var finish = makeRoundFinish
    
    private let teams: [TeamModel]
    private let onRoundFinish = PassthroughSubject<Int, Never>()
    
    init(teams: [TeamModel]) {
        self.teams = teams
    }
    
    #if DEBUG
    deinit {
        print("Coordinator \(self) DEINITED!!!")
    }
    #endif
}

extension RoundCoordinator {
        
    @ViewBuilder func makeGame() -> some View {
        let viewModel = GameViewModel(teams: self.teams,
                                      onRoundFinish: onRoundFinish,
                                      router: self)
        GameView(viewModel: viewModel)
    }
    
    @ViewBuilder func makeRound(round: RoundModel) -> some View {
        let viewModel = RoundViewModel(roundModel: round,
                                       onRoundFinish: onRoundFinish,
                                       router: self)
        RoundView(viewModel: viewModel)
    }
    
    @ViewBuilder func makeRoundFinish(answeredWords: [AnswerModel]) -> some View {
        RoundFinishedView(answeredWords: answeredWords, sendScore: onRoundFinish)
            .environmentObject(self)
    }
}
