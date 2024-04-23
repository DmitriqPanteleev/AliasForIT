//
//  SettingCard.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 22.10.2023.
//

import SwiftUI
import Combine

struct SettingCard: View {
    
    let model: SettingItem
    let tapSabject: SettingSubject
    
    var body: some View {
        Button(subject: tapSabject, model: model) {
            VStack(alignment: model == .rules ? .center : .leading, spacing: 8) {
                iconView
                titleView
                valueView
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 17)
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: model == .rules ? .center : .leading)
            .background(Color.white)
            .cornerRadius(12)
        }
        .settingCardStyle()
    }
}

private extension SettingCard {
    var iconView: some View {
        Image(model.image)
            .resizable()
            .frame(width: 20, height: 20)
            .foregroundColor(.appDarkBlue)
            .padding(9)
            .background(Color.appLightGray)
            .cornerRadius(36)
    }
    
    var titleView: some View {
        Text(model.title)
            .foregroundColor(.appDarkGray)
            .font(.system(size: 16, weight: .thin))
    }
    
    @ViewBuilder
    var valueView: some View {
        switch model {
        case let .timeInterval(interval):
            valueText(String(interval))
        case let .wordsForWin(words):
            valueText(String(words))
        case .rules:
            EmptyView()
        }
    }
    
    func valueText(_ value: String) -> some View {
        Text(value)
            .foregroundColor(.appDarkBlue)
            .font(.system(size: 28))
    }
}

struct SettingCard_Previews: PreviewProvider {
    static var previews: some View {
        SettingCard(model: .wordsForWin(20), tapSabject: SettingSubject())
            .frame(width: .infinity, height: .infinity)
            .background(Color.black)
    }
}
