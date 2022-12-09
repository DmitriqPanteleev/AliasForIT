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
    var stack = Stinsen.NavigationStack(initial: \RoundCoordinator.start)
    
    @Root var start = makeStart
    
    @Route(.fullScreen) var round = makeRound
    @Route(.push) var finish = makeRoundFinish
    
    let onRoundFinish = PassthroughSubject<Int, Never>()
    
#if DEBUG
    deinit {
        print("Coordinator \(self) DEINITED!!!")
    }
#endif
}

extension RoundCoordinator {
    
    @ViewBuilder func makeStart() -> some View {
        let viewModel = GameViewModel(teams: [.defaultTeam1(), .defaultTeam2()], onRoundFinish: onRoundFinish, router: self)
        GameView(viewModel: viewModel)
    }
    
    @ViewBuilder func makeRound(round: RoundModel) -> some View {
        
        let viewModel = RoundViewModel(roundModel: round, onRoundFinish: onRoundFinish, router: self)
        
        RoundView(viewModel: viewModel)
    }
    
    @ViewBuilder func makeRoundFinish(answeredWords: [AnswerModel]) -> some View {
        RoundFinishedView(answeredWords: answeredWords, sendScore: onRoundFinish)
            .environmentObject(self)
    }
    
    //TODO: navigate to list of answered words
}
