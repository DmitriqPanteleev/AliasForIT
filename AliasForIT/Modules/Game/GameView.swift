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
        content
            .background(Color.appBackground.ignoresSafeArea())
            .onAppear {
                viewModel.input.onAppear.send()
            }
    }
}

private extension GameView {
    var content: some View {
        VStack(alignment: .leading) {
            table
                .padding(.top, 30)
            pointLeft
                .padding(.horizontal, 50)
                .padding(.top)
            
            Spacer()
            playButtonBlock
        }
        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
    }
    
    var table: some View {
        SharpedCardView {
            
            VStack(alignment: .leading){
                Text("Команды")
                    .titleWhite()
            }
            .frame(alignment: .leading)
            
            VStack(spacing: 10) {
                ForEach(viewModel.output.teams) { team in
                    TeamCellView(model: team)
                }
            }
        }
        .frame(alignment: .leading)
        .padding(.horizontal, 14)
    }
    
    var pointLeft: some View {
        Text("До победы: \(viewModel.output.pointsLeft) очков")
            .titleTwoWhite()
    }
    
    @ViewBuilder var playButtonBlock: some View {
        VStack {
            
            if (viewModel.output.pointsLeft > 0) {
                PlayButtonView(style: .play) {
                    viewModel.input.onPlayTap.send()
                }
            }
            
            PlayButtonView(style: .stop) {
                viewModel.input.onStopTap.send()
            }
        }
        .padding(.horizontal)
    }
    
}

//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView(viewModel: GameViewModel(teams: [TeamModel.defaultTeam1(), TeamModel.defaultTeam2()], router: ))
//    }
//}
