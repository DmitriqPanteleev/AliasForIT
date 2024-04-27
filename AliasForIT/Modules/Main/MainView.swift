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
            topTeamBlock
            settingsBlock
            Spacer()
        }
        .onAppear(perform: viewModel.input.onAppear.send)
        .safeAreaInset(edge: .top, spacing: 24, content: header)
        .safeAreaInset(edge: .bottom, content: buttonBlock)
        .background((viewModel.output.isSheetsShowing ? Color.white : Color.appLightGray).ignoresSafeArea())
        .animation(.smooth, value: viewModel.output.isSheetsShowing)
        .sheet(isPresented: $viewModel.output.isShowingImageSheet,
               content: imageBottomSheet)
    }
}

private extension MainView {
    func header() -> some View {
        MainHeader(settingsSubject: viewModel.input.toSettings)
    }
    
    var topTeamBlock: some View {
        VStack(spacing: 0) {
            TeamTabControl(selectedTeam: $viewModel.output.selectedTeamId,
                           teamCount: viewModel.output.teams.count)
            // TODO: add subject
            TeamScrollView(selectedTeam: $viewModel.output.selectedTeamId,
                           models: $viewModel.output.teams,
                           addPhotoSubject: viewModel.input.toChooseImage,
                           editNameSubject: viewModel.input.editTeamName,
                           deleteSubject: viewModel.input.deleteTeam)
        }
        .background(Color.white)
    }
    
    @ViewBuilder
    var settingsBlock: some View {
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
    func buttonBlock() -> some View {
        if !viewModel.output.isSheetsShowing {
            PlayButton(tapSubject: viewModel.input.toNewRound)
                .disabled(viewModel.output.isGameDisabled)
                .scaleTransition(from: .bottom, viewModel.output.isSheetsShowing)
        }
    }
    
    func imageBottomSheet() -> some View {
        TeamImageSheet(isShowing: $viewModel.output.isShowingImageSheet,
                       confirmSubject: viewModel.input.editTeamImage)
        .settingsSheetPresentation(height: screenSize.height * 0.3)
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
