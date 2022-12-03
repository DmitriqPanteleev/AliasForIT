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
            .background(Color.black.ignoresSafeArea())
    }
}

private extension RoundView {

    var content: some View {
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
        .onAppear {
            viewModel.input.timerState.send(true)
        }
        .onDisappear {
            viewModel.input.timerState.send(false)
        }
    }
    
    var header: some View {
        HStack {
            
            Spacer()
            
            VStack(spacing: 10) {
                
                Text("\(viewModel.output.roundTime)")
                    .foregroundColor(.yellow)
                
                LinearProgressView(progress: $viewModel.output.roundTime)
            }
            .frame(width: Consts.SharedLayout.cardWidth)
            
            Spacer()
        }
        .frame(alignment: .center)
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
                // Хардкод
                KFImage(URL(string: "https://slovnet.ru/wp-content/uploads/2019/09/4-123.jpg")!)
                    .resizable()
                    .frame(width: Consts.SharedLayout.cardWidth / 4, height: Consts.SharedLayout.cardWidth / 4)
                    .cornerRadius(Consts.SharedLayout.cardWidth / 8)
                    .addBorder(.yellow, width: 4, cornerRadius: Consts.SharedLayout.cardWidth / 8)
                
                Text(viewModel.roundModel.team.name)
                    .font(.largeTitle)
                    .bold()
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
            TimerControlButtonView(style: .pause, callback: {
                timerStateControl(false)
                
            })
        }
    }
    
    // TODO: Separate to components and then to do a bottom sheet
    var resumeButton: some View {
        Button(action: {
            timerStateControl(true)
        }) {
            Text("resume")
                .foregroundColor(.yellow)
        }
    }
    
    @ViewBuilder var background: some View {
        
//        let circleSize = Consts.SharedLayout.cardWidth
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
                .foregroundColor(Color.yellow)
        }
    }
}

private extension RoundView {
    
    func timerStateControl(_ isTimerTicking: Bool) {
        viewModel.input.timerState.send(isTimerTicking)
    }
    
    func answer(_ isAnswered: Bool) {
        viewModel.input.answer.send(isAnswered)
    }
}

struct RoundView_Previews: PreviewProvider {
    static var previews: some View {
        RoundView(viewModel: RoundViewModel(roundModel: RoundModel(team: TeamModel(name: "team", image: "", score: 0), words: []), roundDuration: 10))
    }
}
