//
//  RoundView.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 15.11.2022.
//

import SwiftUI

struct RoundView: View {
    
    @StateObject var viewModel: RoundViewModel
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            Text("\(viewModel.output.roundTime)")
                .foregroundColor(.white)
            pauseButton
            resumeButton
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.ignoresSafeArea())
        .onAppear {
            viewModel.input.timerState.send(true)
        }
        .onDisappear {
            viewModel.input.timerState.send(false)
        }
    }
}

private extension RoundView {

    var pauseButton: some View {
        Button(action: pause) {
            Text("pause")
                .foregroundColor(.yellow)
        }
    }
    
    var resumeButton: some View {
        Button(action: resume) {
            Text("resume")
                .foregroundColor(.yellow)
        }
    }
}

private extension RoundView {
    
    func pause() {
        viewModel.input.timerState.send(false)
    }
    
    func resume() {
        viewModel.input.timerState.send(true)
    }
    
    func stop() {
        // viewModel.input.onStopTap.send()
    }
    
}

struct RoundView_Previews: PreviewProvider {
    static var previews: some View {
        RoundView(viewModel: RoundViewModel(roundModel: RoundModel(team: TeamModel(name: "team", image: "", score: 0), words: [:]), roundDuration: 10))
    }
}
