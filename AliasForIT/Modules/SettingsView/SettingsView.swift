//
//  SettingsView.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 15.11.2022.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject var viewModel: SettingsViewModel
    
    var body: some View {
        VStack {
            cellsBlock
            Spacer()
        }
        .background(Color.black.ignoresSafeArea())
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
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: SettingsViewModel())
    }
}
