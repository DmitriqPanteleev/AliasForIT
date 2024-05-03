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
            TeamScoreList(currentTeamId: viewModel.output.currentTeam?.id ?? 0,
                          models: viewModel.output.teams)
            Spacer()
        }
        .safeAreaInset(edge: .top, content: headerView)
        .safeAreaInset(edge: .bottom, content: buttonView)
        .background(Color.white.ignoresSafeArea())
        .onAppear(perform: viewModel.input.onAppear.send)
    }
}

private extension GameView {
    func headerView() -> some View {
        GameHeaderView(tapAction: viewModel.input.onStopTap.send)
    }
    
    func buttonView() -> some View {
        Button(action: viewModel.input.onPlayTap.send) {
            Text("Играть")
                .buttonTitle()
        }
        .textButtonStyle(disabled: viewModel.output.pointsLeft < 0)
        .padding(.horizontal)
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
