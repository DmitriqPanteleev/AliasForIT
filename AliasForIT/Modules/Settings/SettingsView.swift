//
//  SettingsView.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 15.11.2022.
//

// ПОКА НЕ ИЗПОЛЬЗУЕТСЯ

import SwiftUI

struct SettingsView: View {
    
    @StateObject var viewModel: SettingsViewModel
    
    var body: some View {
        VStack {
            Text("Настройки игры")
                .titleWhite()
                .padding()
            cellsBlock
            Spacer()
        }
        .background(Color.appBackground.ignoresSafeArea())
        .onDisappear {
            viewModel.onBackTrigger.send()
        }
    }
}

private extension SettingsView {
    
    var cellsBlock: some View {
        VStack(spacing: 30) {
            CountSettingCellView(option: viewModel.output.points,
                                 style: .points,
                                 onChange: viewModel.input.onChangePoints)
            
            CountSettingCellView(option: viewModel.output.roundTime,
                                 style: .time,
                                 onChange: viewModel.input.onChangeRoundTime)
            
            SwitchSettingsCellView(option: $viewModel.output.audio,
                                   style: .audio,
                                   onChange: viewModel.input.onChangeAudio)
            
            SwitchSettingsCellView(option: $viewModel.output.lastWord,
                                   style: .lastWord,
                                   onChange: viewModel.input.onChangeLastWord)
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView(viewModel: SettingsViewModel())
//    }
//}
