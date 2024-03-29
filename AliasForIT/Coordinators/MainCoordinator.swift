//
//  MainCoordinator.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 19.12.2022.
//

import SwiftUI
import Combine
import Stinsen

final class MainCoordinator: NavigationCoordinatable {
    
    var stack = Stinsen.NavigationStack<MainCoordinator>(initial: \.start)
    
    @Root var start = makeStart
    
    @Route(.modal) var team = makeEditTeam
    @Route(.modal) var settings = makeSettingsScreen
    @Route(.fullScreen) var game = makeGame
    
    
    private let onBackTrigger = PassthroughSubject<Void, Never>()
    
    #if DEBUG
    deinit {
        print("Coordinator \(self) deinited")
    }
    #endif
}

extension MainCoordinator {
    
    @ViewBuilder func makeStart() -> some View {
        let viewModel = MainViewModel(onUpdate: onBackTrigger, router: self)
        MainView(viewModel: viewModel)
    }
    
    @ViewBuilder func makeEditTeam(model: TeamModel?) -> some View {
        let viewModel = EditTeamViewModel(onSave: onBackTrigger,
                                          model: model,
                                          router: self)
        EditTeamView(viewModel: viewModel)
    }
    
    @ViewBuilder func makeSettingsScreen() -> some View {
        let viewModel = SettingsViewModel(onBackTrigger: onBackTrigger)
        SettingsView(viewModel: viewModel)
    }
    
    func makeGame(teams: [TeamModel]) -> NavigationViewCoordinator<RoundCoordinator> {
        return NavigationViewCoordinator(RoundCoordinator(teams: teams))
    }
}
