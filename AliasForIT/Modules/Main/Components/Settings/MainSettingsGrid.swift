//
//  MainSettingsGrid.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 22.10.2023.
//

import SwiftUI

struct MainSettingsGrid: View {
    let models: [SettingItem]
    let tapSubject: SettingSubject
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(spacing: 16) {
                ForEach(models, id: \.title) { model in
                    SettingCard(model: model, tapSabject: tapSubject)
                }
            }
            SettingCard(model: .rules, 
                        tapSabject: tapSubject)
        }
        .padding(.horizontal)
    }
}

#if DEBUG
struct MainSettingsGrid_Previews: PreviewProvider {
    static var previews: some View {
        MainSettingsGrid(models: [], tapSubject: SettingSubject())
            .padding()
            .background(Color.appGray)
    }
}
#endif
