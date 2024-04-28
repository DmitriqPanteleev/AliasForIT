//
//  SettingItemSheet.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 23.04.2024.
//

import SwiftUI

struct SettingItemSheet: View {
    
    @State private var selected: Int
    
    @Binding var isShowing: Bool
    
    let setting: SettingItem
    let confirmSubject: SettingSubject
    
    private var options: [Int] {
        switch setting {
        case .timeInterval:
            return [30, 40, 50, 60]
        case .wordsForWin:
            return [15, 30, 45, 60, 75, 90]
        case .rules:
            return []
        }
    }
    
    init(isShowing: Binding<Bool>,
         setting: SettingItem,
         confirmSubject: SettingSubject) {
        self._isShowing = isShowing
        
        switch setting {
        case .timeInterval(let value), .wordsForWin(let value):
            selected = value
        case .rules:
            selected = 0
        }
        
        self.setting = setting
        self.confirmSubject = confirmSubject
    }
    
    var body: some View {
        VStack {
            Spacer()
            optionListView
            Spacer()
            confirmButton
        }
        .padding()
    }
}

private extension SettingItemSheet {
    var optionListView: some View {
        VStack(alignment: .center, spacing: 4) {
             HStack {
                ForEach(options, id: \.hashValue) { option in
                    optionCircleView(option)
                    if option != options.last {
                        Spacer()
                    }
                }
                .background(alignment: .center, content: lineOverlay)
            }
            
            HStack {
                ForEach(options, id: \.hashValue) { option in
                    Text(option)
                        .option(color: selected == option ? .appDarkBlue : .appDarkGray)
                        .frame(width: 28)
                    
                    if option != options.last {
                        Spacer()
                    }
                }
            }
        }
        .animation(.smooth, value: selected)
    }
    
    func optionCircleView(_ value: Int) -> some View {
        Button(action: { selected = value }) {
            VStack(spacing: 8) {
                Circle()
                    .frame(width: 28, height: 28)
                    .foregroundColor(selected == value ? .appDarkBlue : .appGray)
            }
        }
        .scaledButtonStyle()
        
    }
    
    func lineOverlay() -> some View {
        Rectangle()
            .fill(Color.appGray)
            .frame(height: 2)
            .frame(maxWidth: .infinity)
    }
    
    var confirmButton: some View {
        Button(action: confirmChoice) {
            Text("Готово")
                .buttonTitle()
        }
        .textButtonStyle(disabled: selected == 0)
    }
}

private extension SettingItemSheet {
    func confirmChoice() {
        guard selected != 0, let setting = buildSetting() else { return }

        defer { confirmSubject.send(setting) }
        
        isShowing = false
    }
    
    func buildSetting() -> SettingItem? {
        switch setting {
        case .timeInterval:
            return .timeInterval(selected)
        case .wordsForWin:
            return .wordsForWin(selected)
        case .rules:
            return nil // will never be executed
        }
    }
}

#Preview {
    SettingItemSheet(isShowing: .constant(true),
                     setting: .rules,
                     confirmSubject: SettingSubject())
}
