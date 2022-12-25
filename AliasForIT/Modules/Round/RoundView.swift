//
//  RoundView.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 15.11.2022.
//

import SwiftUI
import Kingfisher

struct RoundView: View {
    
    @StateObject var viewModel: RoundViewModel
    
    var body: some View {
        content
            .onAppear {
                viewModel.input.timerState.send(true)
            }
            .onDisappear {
                viewModel.input.timerState.send(false)
            }
    }
}

private extension RoundView {
    
    @ViewBuilder var content: some View {
        
        switch viewModel.output.state {
        case .playing:
            playContent
        case .paused:
            pausedContent
        }
        
    }
    
    var header: some View {
        HStack {
            
            Spacer()
            
            VStack(spacing: 10) {
                
                Text("\(viewModel.output.roundTime)")
                    .foregroundColor(.yellow)
                
                LinearProgressView(progress: $viewModel.output.roundTime, total: UserStorage.shared.roundTime)
                
            }
            .frame(width: Consts.SharedLayout.cardWidth)
            
            Spacer()
        }
        .frame(alignment: .center)
    }
    
    @ViewBuilder var background: some View {

        let circleSize = UIScreen.main.bounds.width + 32
        
        VStack {
            
            Spacer()
            RoundedRectangle(cornerRadius: circleSize / 5)
                .path(in: CGRect(origin:
                                    CGPoint(x: UIScreen.main.bounds.midX - circleSize / 2,
                                            y: UIScreen.main.bounds.maxY - circleSize / 3),
                                 size:
                                    CGSize(width: circleSize,
                                           height: circleSize)))
                .gradientForeground(colors: [.appYellow, .appOrange],
                                    startPoint: .leading,
                                    endPoint: .trailing)
        }
    }
}

// state of playing
private extension RoundView {
    
    var playContent: some View {
        ZStack(alignment: .top) {
            
            background
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                header
                cards
                Spacer()
                scoreTable
            }
            .padding(.horizontal)
            .padding(.bottom, 5)
            .padding(.top, 20)
        }
        .background(Color.appBackground.ignoresSafeArea())
    }
    
    var cards: some View {
        ZStack {
            
            ForEach(viewModel.roundModel.words.reversed(), id: \.self) { word in
                SwipableCardView(word: word, action: viewModel.input.answer)
                    .environmentObject(viewModel)
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
    
    var scoreTable: some View {
        HStack {
            
            Spacer()
            
            VStack(spacing: 5) {
                
                Image(viewModel.roundModel.team.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: Consts.SharedLayout.cardWidth / 4, height: Consts.SharedLayout.cardWidth / 4)
                    .cornerRadius(Consts.SharedLayout.cardWidth / 8)
                    .addBorder(.yellow, width: 4, cornerRadius: Consts.SharedLayout.cardWidth / 8)
                
                Text(viewModel.roundModel.team.name)
                    .titleTwoWhite()
                    .lineLimit(1)
                    .foregroundColor(.white)
                
                HStack {
                    Text("\(viewModel.output.currentScore)")
                        .foregroundColor(.white)
                        .padding(.vertical, 5)
                }
                .frame(width: 50)
                .background(.black)
                .cornerRadius(10)
            }
            
            Spacer()
        }
        .overlay(alignment: .bottomTrailing) {
            TimerControlButtonView(style: .pause) {
                self.timerStateControl(false)
            }
        }
    }
}

// state of pause
private extension RoundView {
    
    var pausedContent: some View {
        VStack(alignment: .center) {
            
            header
            
            Spacer()
            
            // Хардкод
            Image(systemName: "pause.circle")
                .foregroundColor(.appYellow)
                .scaleEffect(2)
            
            Spacer()
            
            PlayButtonView(style: .next) {
                self.timerStateControl(true)
            }
            .padding(.bottom, 10)
            
            PlayButtonView(style: .stop, action: closeRound)
            
        }
        .padding(.horizontal)
        .padding(.bottom, 5)
        .padding(.top, 20)
        .background(Color.appBackground.ignoresSafeArea())
    }
}

private extension RoundView {
    
    func timerStateControl(_ timerState: Bool) {
        viewModel.input.timerState.send(timerState)
    }
    
    func answer(_ isAnswered: Bool) {
        viewModel.input.answer.send(isAnswered)
    }
    
    func closeRound() {
        viewModel.input.onCloseTap.send()
    }
}

//struct RoundView_Previews: PreviewProvider {
//    static var previews: some View {
//        RoundView(viewModel: RoundViewModel(roundModel: RoundModel(team: TeamModel(name: "team", image: "", score: 0), words: []), roundDuration: 10))
//    }
//}
