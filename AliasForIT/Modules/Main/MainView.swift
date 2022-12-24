//
//  MainView.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 12.12.2022.
//

import SwiftUI
import Combine

struct MainView: View {
    
    @StateObject var viewModel: MainViewModel
    
    var body: some View {
        content
            .background(Color.appBackground.ignoresSafeArea())
            .onAppear(perform: onAppear)
    }
}

private extension MainView {
    
    var content: some View {
        VStack(spacing: 16) {
            
            HStack {
                // TODO: CustomAppBar
                Text("Начать игру")
                    .titleWhite()
                
                Spacer()
                
                Image(systemName: "slider.vertical.3")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
                    .onTapGesture(perform: onSettingsTap)
            }
            .padding()
            
            ScrollView {
                VStack(spacing: 6) {
                    
                    teams
                        .padding(.bottom, 10)
                    
                    settings
                }
                .padding(.horizontal, 14)
            }
            
            PlayButtonView(style: .play, action: onPlayTap)
                .padding(.horizontal, 14)
                .disabled(viewModel.output.teams.count < 2)
            
        }
    }
    
    var teams: some View {
        
        SharpedCardView {
            VStack {
                HStack {
                    Text("Команды")
                        .titleTwoWhite()
                    
                    Spacer()
                    
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

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView(viewModel: <#T##MainViewModel#>)
//    }
//}
