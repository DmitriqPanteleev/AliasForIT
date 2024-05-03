//
//  RoundView.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 15.11.2022.
//

import SwiftUI
import Kingfisher

struct RoundView: View {
    
    @Environment(\.screenSize) private var screenSize
    @Environment(\.safeAreaInsets) private var safeArea
    
    @Namespace private var cardSpace
    @Namespace private var imageSpace
    
    @StateObject var viewModel: RoundViewModel
    
    var body: some View {
        contentView
            .safeAreaInset(edge: .top, content: headerView)
            .safeAreaInset(edge: .bottom, content: bottomView)
            .ignoresSafeArea()
            .onAppear(perform: startTimer)
            .onDisappear(perform: stopTimer)
            .animation(.smooth, value: viewModel.output.state)
    }
}

private extension RoundView {
    @ViewBuilder
    func headerView() -> some View {
        if viewModel.output.state != .finished {
            RoundTimerView(time: viewModel.output.roundTime,
                           totalTime: viewModel.output.totalRoundTime)
            .frame(maxWidth: .infinity)
            .padding(.top, safeArea.top + 32)
            .padding(.bottom, 28)
            .background(Color.white)
            .cornerRadius(32, corners: [.bottomLeft, .bottomRight])
        } else {
            Text("Результаты раунда")
                .font(.system(size: 28, weight: .medium))
                .foregroundColor(.appDarkBlue)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, safeArea.top + 16)
                .padding([.leading, .bottom])
                .background(Color.appLightGray)
                .cornerRadius(32, corners: [.bottomLeft, .bottomRight])
        }
    }
    
    @ViewBuilder
    func bottomView() -> some View {
        VStack(spacing: 24) {
            if viewModel.output.state != .finished {
                ScoreView(score: viewModel.output.currentScore,
                          style: .big,
                          isCurrent: true)
                .matchedGeometryEffect(id: viewModel.roundModel.team.score, in: imageSpace)
            }
            
            if viewModel.output.state == .finished {
                Button(action: viewModel.input.onFinish.send) {
                    Text("Продолжить")
                        .buttonTitle()
                }
                .textButtonStyle()
                .padding(.horizontal)
                .padding(.top, 8)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 60)
        .padding(.bottom, safeArea.bottom + 16)
        .background(Color.white)
        .cornerRadius(32, corners: [.topLeft, .topRight])
        .overlay(alignment: viewModel.output.state == .finished ? .topLeading : .top,
                 content: bottomImageView)
    }
    
    @ViewBuilder
    func bottomImageView() -> some View {
        if viewModel.output.state != .paused {
            HStack {
                
                RoundTeamCell(image: viewModel.roundModel.team.image,
                              isSmall: true,
                              isPaused: viewModel.output.state == .paused,
                              timerSubject: viewModel.input.timerState)
                .matchedGeometryEffect(id: viewModel.roundModel.team.name, in: imageSpace)
                
                if viewModel.output.state == .finished {
                    Spacer()
                    
                    ScoreView(score: viewModel.output.currentScore,
                              style: .expanded,
                              isCurrent: true)
                    .matchedGeometryEffect(id: viewModel.roundModel.team.score, in: imageSpace)
                }
            }
            .offset(y: -43)
            .padding(.horizontal, viewModel.output.state == .finished ? 24 : 0)
        }
    }
    
    @ViewBuilder 
    var contentView: some View {
        VStack(spacing: 0) {
            switch viewModel.output.state {
            case .playing, .paused:
                playContentView
            case .finished:
                finishedContentView
            }
        }
    }
}

private extension RoundView {
    var playContentView: some View {
        VStack {
            Spacer()
            cardsView
            Spacer()
        }
        .background(Color.appLightGray)
        .overlay(content: pauseOverlay)
    }
    
    @ViewBuilder
    var cardsView: some View {
        if viewModel.output.state != .finished {
            ZStack {
                ForEach(viewModel.roundModel.words.reversed(), id: \.hashValue) { word in
                    let isFirstWord = viewModel.output.currentWord == word
                    
                    SwipeCardView(word: word,
                                  isFirst: isFirstWord,
                                  action: viewModel.input.answer)
                    .matchedGeometryEffect(id: word,
                                           in: cardSpace)
                    .disabled(!viewModel.output.isSwipesEnabled)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
    
    @ViewBuilder
    func pauseOverlay() -> some View {
        if viewModel.output.state == .paused {
            VStack {
                Spacer()
                RoundTeamCell(image: viewModel.roundModel.team.image,
                              isSmall: false,
                              isPaused: viewModel.output.state == .paused,
                              timerSubject: viewModel.input.timerState)
                .matchedGeometryEffect(id: viewModel.roundModel.team.name, in: imageSpace)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(Color.white.ignoresSafeArea())
        }
    }
    
    var finishedContentView: some View {
        VStack {
            if !viewModel.output.answeredWords.isEmpty {
                AnsweredWordsView(words: $viewModel.output.answeredWords)
                Spacer()
            } else {
                Text("Ебать вы лошки") // TODO: стейт
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.appLightGray)
    }
}

private extension RoundView {
    func startTimer() {
        viewModel.input.timerState.send(true)
    }
    
    func stopTimer() {
        viewModel.input.timerState.send(false)
    }
}
