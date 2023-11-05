//
//  MainSettingsGrid.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 22.10.2023.
//

import SwiftUI

struct MainSettingsGrid: View {
    
    let items: [GridItem] = .init(repeating: .init(.flexible(), spacing: 16), count: 2)
    let models: [SettingItem] = SettingItem.allCases
    let tapSubject: SettingSubject
    
    var body: some View {
        LazyVGrid(columns: items, spacing: 16) {
            ForEach(models, id: \.hashValue) { model in
                SettingCard(model: model, tapSabject: tapSubject)
            }
        }
        .padding(.horizontal)
    }
}

#if DEBUG
struct MainSettingsGrid_Previews: PreviewProvider {
    static var previews: some View {
        MainSettingsGrid(tapSubject: SettingSubject())
            .padding()
            .background(Color.appGray)
    }
}
#endif
