//
//  GameView.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 03.12.2022.
//

import SwiftUI
import Combine

struct GameView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var viewModel: GameViewModel
    
    var body: some View {
        generalContent
            .safeAreaInset(edge: .top, content: headerContent)
            .background(Color.white.ignoresSafeArea())
            .onAppear(perform: onAppear)
    }
}

private extension GameView {
    func headerContent() -> some View {
        GameHeaderView(tapAction: dismissScreen)
    }
    
    var generalContent: some View {
        VStack(spacing: 0) {
            let currentId = viewModel.output.currentTeam?.id ?? 0
            TeamScoreList(currentTeamId: currentId,
                          models: viewModel.output.teams)
            PlayButton(tapSubject: viewModel.input.onPlayTap)
                .disabled(viewModel.output.pointsLeft < 0)
        }
    }
}

private extension GameView {
    func onAppear() {
        viewModel.input.onAppear.send()
    }
    
    
    // MARK: - Navigation
    func onPlayTap() {
        viewModel.input.onPlayTap.send()
    }
    
    func dismissScreen() {
        dismiss()
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(teams: [TeamModel.defaultTeam1(), TeamModel.defaultTeam2()],
                                          settingsManager: SettingsManager(),
                                          onRoundFinish: PassthroughSubject<Int, Never>(),
                                          router: nil))
    }
}
