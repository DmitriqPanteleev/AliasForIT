//
//  GameView.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 03.12.2022.
//

import SwiftUI
import Combine

struct GameView: View {
    
    @StateObject var viewModel: GameViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            let currentId = viewModel.output.currentTeam?.id ?? 0
            
            TeamScoreList(currentTeamId: currentId,
                          models: viewModel.output.teams)
            
            Spacer()
            
            Button(action: viewModel.input.onPlayTap.send) {
                Text("Играть")
                    .buttonTitle()
            }
            .textButtonStyle(disabled: viewModel.output.pointsLeft < 0)
        }
        .safeAreaInset(edge: .top, content: headerContent)
        .background(Color.white.ignoresSafeArea())
        .onAppear(perform: viewModel.input.onAppear.send)
    }
}

private extension GameView {
    func headerContent() -> some View {
        GameHeaderView(tapAction: viewModel.input.onStopTap.send)
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
