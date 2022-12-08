//
//  RoundCoordinator.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 08.12.2022.
//

import Foundation
import SwiftUI
import Stinsen

final class RoundCoordinator: NavigationCoordinatable {
    var stack = Stinsen.NavigationStack(initial: \RoundCoordinator.start)
    
    @Root var start = makeStart
    
    @Route(.fullScreen) var round = makeRound
    
#if DEBUG
    deinit {
        print("Coordinator \(self) DEINITED!!!")
    }
#endif
}

extension RoundCoordinator {
    
    @ViewBuilder func makeStart() -> some View {
        let viewModel = GameViewModel(teams: [.defaultTeam1(), .defaultTeam2()], router: self)
        GameView(viewModel: viewModel)
    }
    
    @ViewBuilder func makeRound(round: RoundModel) -> some View {
        
        let viewModel = RoundViewModel(roundModel: round, router: self)
        
        RoundView(viewModel: viewModel)
    }
    
    //TODO: navigate to list of answered words
}
