//
//  MainView.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 12.12.2022.
//

import SwiftUI

struct MainView: View {
    @Environment(\.screenSize) private var screenSize
    @Environment(\.safeAreaInsets) private var safeArea
    
    @StateObject var viewModel: MainViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            teamView
            settingsView
            Spacer()
        }
        .onAppear(perform: viewModel.input.onAppear.send)
        .safeAreaInset(edge: .top, spacing: 24, content: headerView)
        .safeAreaInset(edge: .bottom, content: buttonBlockView)
        .background((viewModel.output.isSheetsShowing ? Color.white : Color.appLightGray).ignoresSafeArea())
        .animation(.smooth, value: viewModel.output.isSheetsShowing)
        .sheet(isPresented: $viewModel.output.teamSheetConfig.isShowing,
               content: teamBottomSheet)
        .sheet(isPresented: $viewModel.output.settingSheetConfig.isShowing,
               content: settingBottomSheet)
    }
}

private extension MainView {
    func headerView() -> some View {
        MainHeader(addTeamSubject: viewModel.input.toAppendTeam)
    }
    
    var teamView: some View {
        VStack(spacing: 0) {
            TeamTabControl(selectedTeam: $viewModel.output.selectedTeamId,
                           teamCount: viewModel.output.teams.count)
            TeamScrollView(selectedTeam: $viewModel.output.selectedTeamId,
                           models: $viewModel.output.teams,
                           addPhotoSubject: viewModel.input.toChooseImage,
                           editNameSubject: viewModel.input.editTeamName,
                           deleteSubject: viewModel.input.deleteTeam)
            .animation(.bouncy, value: viewModel.output.teams.count)
        }
        .background(Color.white)
    }
    
    @ViewBuilder
    var settingsView: some View {
        if !viewModel.output.isSheetsShowing {
            VStack {
                MainSettingsGrid(models: viewModel.output.settings,
                                 tapSubject: viewModel.input.toSomeSetting)
                Spacer()
            }
            .background(Color.appLightGray)
            .cornerRadius(24, corners: [.topLeft, .topRight])
            .scaleTransition(from: .bottom, viewModel.output.isSheetsShowing)
        }
    }
    
    @ViewBuilder
    func buttonBlockView() -> some View {
        if !viewModel.output.isSheetsShowing {
            Button(action: viewModel.input.toNewRound.send) {
                Text("Начать игру")
                    .buttonTitle()
            }
            .textButtonStyle(disabled: viewModel.output.isGameDisabled)
            .scaleTransition(from: .bottom, viewModel.output.isSheetsShowing)
            .padding(.horizontal)
        }
    }
    
    @ViewBuilder
    func settingBottomSheet() -> some View {
        SettingItemSheet(isShowing: $viewModel.output.settingSheetConfig.isShowing,
                         setting: viewModel.output.settingSheetConfig.setting,
                         confirmSubject: viewModel.input.confirmSetting)
        .settingsSheetPresentation(height: screenSize.height * 0.3)
    }
    
    @ViewBuilder
    func teamBottomSheet() -> some View {
        let type = viewModel.output.teamSheetConfig.type
        TeamSheet(isShowing: $viewModel.output.teamSheetConfig.isShowing,
                  type: type,
                  confirmSubject: viewModel.input.updateTeam)
        .settingsSheetPresentation(height: screenSize.height * (type == .adding ? 0.4 : 0.3))
    }
}

#if DEBUG
import Combine
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel(teamStorage: TeamStorage(),
                                          settingsManager: SettingsManager(),
                                          onUpdate: VoidSubject(),
                                          router: nil))
    }
}
#endif
