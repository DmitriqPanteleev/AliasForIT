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
    
    // MARK: Routes
    @Root var start = makeStart
    
    @Route(.modal) var team = makeEditTeam
    @Route(.modal) var settings = makeSettingsScreen
    @Route(.fullScreen) var game = makeGame
    
    // MARK: Dependencies
    private let teamStorage: TeamControlable & TeamEditable = TeamStorage()
    private let settingsManager: SettingsManager = SettingsManager()
    
    private let onBackTrigger = PassthroughSubject<Void, Never>()
    
    deinit {
    #if DEBUG
        print("Coordinator \(self) deinited")
    #endif
    }
}

// TODO: Вынести все в отдельный координатор
extension MainCoordinator {
    
    @ViewBuilder func makeStart() -> some View {
        let viewModel = MainViewModel(teamStorage: teamStorage,
                                      settingsManager: settingsManager,
                                      onUpdate: onBackTrigger,
                                      router: self)
        MainView(viewModel: viewModel)
    }
    
    @ViewBuilder func makeEditTeam(model: TeamModel?) -> some View {
        let viewModel = EditTeamViewModel(onSave: onBackTrigger,
                                          model: model,
                                          router: self)
        EditTeamView(viewModel: viewModel)
    }
    
    @ViewBuilder func makeSettingsScreen() -> some View {
        // TODO: make screen
    }
    
    func makeGame(teams: [TeamModel]) -> NavigationViewCoordinator<GameCoordinator> {
        return NavigationViewCoordinator(GameCoordinator(teams: teams, settingsManager: settingsManager))
    }
}
