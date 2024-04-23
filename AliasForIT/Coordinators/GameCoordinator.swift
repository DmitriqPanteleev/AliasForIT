//
//  RoundCoordinator.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 08.12.2022.
//

import SwiftUI
import Combine
import Stinsen

final class GameCoordinator: NavigationCoordinatable {
    
    var stack = Stinsen.NavigationStack<GameCoordinator>(initial: \.game)
    
    // MARK: Routes
    @Root var game = makeGame
    @Route(.fullScreen) var round = makeRound
    @Route(.push) var finish = makeRoundFinish
    
    // MARK: Dependencies
    private let settingsManager: GameConfigurable
    
    // MARK: External
    private let teams: [TeamModel]
    
    // MARK: Internal
    private let onRoundFinish = PassthroughSubject<Int, Never>()
    
    init(teams: [TeamModel], settingsManager: GameConfigurable) {
        self.teams = teams
        self.settingsManager = settingsManager
    }
    
    #if DEBUG
    deinit {
        print("Coordinator \(self) DEINITED!!!")
    }
    #endif
}

extension GameCoordinator {
        
    @ViewBuilder func makeGame() -> some View {
        let viewModel = GameViewModel(teams: teams,
                                      settingsManager: settingsManager,
                                      onRoundFinish: onRoundFinish,
                                      router: self)
        GameView(viewModel: viewModel)
    }
    
    @ViewBuilder func makeRound(round: RoundModel) -> some View {
        let viewModel = RoundViewModel(roundModel: round, 
                                       settingsManager: settingsManager,
                                       onRoundFinish: onRoundFinish,
                                       router: self)
        RoundView(viewModel: viewModel)
    }
    
    @ViewBuilder func makeRoundFinish(answeredWords: [AnswerModel]) -> some View {
        RoundFinishedView(answeredWords: answeredWords, sendScore: onRoundFinish)
            .environmentObject(self)
    }
}
