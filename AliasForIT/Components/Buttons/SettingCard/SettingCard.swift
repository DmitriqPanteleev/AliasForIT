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
            VStack(alignment: .leading, spacing: 8) {
                iconView()
                titleView()
                valueView()
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 17)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
            .cornerRadius(12)
        }
        .settingCardStyle()
    }
}

private extension SettingCard {
    func iconView() -> some View {
        Image(model.image)
            .resizable()
            .frame(width: 20, height: 20)
            .foregroundColor(.appDarkBlue)
            .padding(9)
            .background(Color.appLightGray)
            .cornerRadius(36)
    }
    
    func titleView() -> some View {
        Text(model.title)
            .foregroundColor(.appDarkGray)
            .font(.system(size: 16, weight: .thin))
    }
    
    func valueView() -> some View {
        Text("1:00")
            .foregroundColor(.appDarkBlue)
            .font(.system(size: 28))
    }
}

struct SettingCard_Previews: PreviewProvider {
    static var previews: some View {
        SettingCard(model: .wordsForWin, tapSabject: SettingSubject())
            .frame(width: .infinity, height: .infinity)
            .background(Color.black)
    }
}
