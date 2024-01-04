//
//  MainView.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 12.12.2022.
//

import SwiftUI
import Combine // TODO: убрать потом

struct MainView: View {
    
    @State private var selectedTeam = 0
    @State var models: [TeamModel] = [.defaultTeam1(), .defaultTeam2(), .defaultTeam1()]
    @StateObject var viewModel: MainViewModel
    
    var body: some View {
        viewContent()
    }
}

private extension MainView {
    
    func viewContent() -> some View {
        VStack(spacing: 0) {
            topTeamBlock
            VStack {
                MainSettingsGrid(tapSubject: SettingSubject())
                Spacer()
                buttonBlock
            }
            .padding(.top)
            .background(Color.appLightGray)
            .cornerRadius(24, corners: [.topLeft, .topRight])
            .ignoresSafeArea()
        }
    }
    
    var topTeamBlock: some View {
        VStack(spacing: 24) {
            MainHeader(settingsSubject: PassthroughSubject<Void, Never>())
            TeamTabControl(selectedTeam: $selectedTeam,
                           teamCount: models.count)
            TeamScrollView(selectedTeam: $selectedTeam,
                           models: $models,
                           addPhotoSubject: PassthroughSubject<Void, Never>(),
                           editNameSubject: PassthroughSubject<String, Never>(),
                           deleteSubject: VoidSubject())
        }
        .background(Color.white)
    }
    
    // TODO: возможно переместить сюда кнопку добавления команды
    @ViewBuilder
    var buttonBlock: some View {
        
        let connectedScenes = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
        
        let window = connectedScenes.first?
            .windows
            .first { $0.isKeyWindow }
        
        let bottomSafeArea = window?.safeAreaInsets.bottom
        
        HStack(spacing: 40) {
            Spacer()
            PlayButton(tapSubject: VoidSubject())
                .disabled(models.count < 2)
            Spacer()
        }
        .padding(.bottom, bottomSafeArea)
    }
    
    var content: some View {
        VStack(spacing: 16) {
            PlayButtonView(style: .play, action: onPlayTap)
                .padding(.horizontal, 14)
                .disabled(viewModel.output.teams.count < 2)
        }
    }
    
    var teams: some View {
        
        SharpedCardView {
            VStack {
                HStack {
                    AddButtonView {
                        onAddTap()
                    }
                }
                
                if viewModel.output.teams.isEmpty {
                    
                    Text("В игре участвуют минимум 2 команды")
                        .titleThreeWhite()
                        .frame(alignment: .center)
                        .padding(8)
                    
                } else if viewModel.output.teams.count == 1 {
                    
                    EditableTeamCellView(model: viewModel.output.teams.first!,
                                         onEdit: { onAddTap(viewModel.output.teams.first!) },
                                         onDelete: { onDeleteTap(viewModel.output.teams.first!.id) })
                    .padding(.bottom, 8)
                    
                    Text("Добавьте еще 1 команду")
                        .titleThreeWhite()
                        .frame(alignment: .center)
                    
                } else {
                    
                    ForEach(viewModel.output.teams) { team in
                        EditableTeamCellView(model: team,
                                             onEdit: { onAddTap(team) },
                                             onDelete: { onDeleteTap(team.id)})
                    }
                    
                }
            }
        }
    }
    
    var settings: some View {
        
        VStack {
            SharpedCardView {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Время раунда")
                            .titleTwoWhite()
                        Text(viewModel.output.roundTime.description)
                            .titleWhite()
                            .gradientForeground(colors: [.appYellow, .appOrange],
                                                startPoint: .leading,
                                                endPoint: .trailing)
                    }
                    .frame(alignment: .leading)
                    
                    Spacer()
                    // image
                }
            }
            
            SharpedCardView {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Слов до победы")
                            .titleTwoWhite()
                        Text(viewModel.output.wordsForWin.description)
                            .titleWhite()
                            .gradientForeground(colors: [.appYellow, .appOrange],
                                                startPoint: .leading,
                                                endPoint: .trailing)
                    }
                    .frame(alignment: .leading)
                    
                    Spacer()
                    // image
                }
            }
            
            // Card for rules
        }
    }
}

private extension MainView {
    
    func onAppear() {
        viewModel.input.onAppear.send()
    }
    
    func onSettingsTap() {
        viewModel.input.onSettingsTap.send()
    }
    
    func onAddTap(_ team: TeamModel? = nil) {
        viewModel.input.onAddTap.send(team)
    }
    
    func onDeleteTap(_ id: Int) {
        viewModel.input.onDelete.send(id)
    }
    
    func onPlayTap() {
        viewModel.input.onPlayTap.send()
    }
}

#if DEBUG
import Combine
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel(onUpdate: PassthroughSubject<Void, Never>(), router: nil))
    }
}
#endif
