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
            .onAppear(perform: onAppear)
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
        
        HStack(spacing: 0) {
            
            Text("До победы:")
                .titleTwoWhite()
            
             Text(" \(viewModel.output.pointsLeft) ")
                .titleTwoYellow()
            
            Text("очков")
                .titleTwoWhite()
        }
    }
    
    @ViewBuilder var playButtonBlock: some View {
        
        VStack {
            
            if (viewModel.output.pointsLeft > 0) {
                PlayButtonView(style: .play, action: onPlayTap)
            }
            
            PlayButtonView(style: .stop, action: onStopTap)
        }
        .padding(.horizontal)
    }
    
}

private extension GameView {
    
    func onAppear() {
        viewModel.input.onAppear.send()
    }
    
    func onPlayTap() {
        viewModel.input.onPlayTap.send()
    }
    
    func onStopTap() {
        viewModel.input.onStopTap.send()
    }
}

//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView(viewModel: GameViewModel(teams: [TeamModel.defaultTeam1(), TeamModel.defaultTeam2()], router: ))
//    }
//}
