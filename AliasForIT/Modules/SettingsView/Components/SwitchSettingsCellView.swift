//
//  SwitchSettingsCellView.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 15.11.2022.
//

import SwiftUI
import Combine

struct SwitchSettingsCellView: View {
    
    let option: Binding<Bool>
    let style: SettingsCellStyle
    let onChange: PassthroughSubject<Bool, Never>
    
    var body: some View {
        HStack {
            Image(systemName: style.icon)
                .padding(.trailing)
                .foregroundColor(.yellow)
            
            Text(style.title)
                .foregroundColor(.white)
                .lineLimit(1)
            
            switchable
        }
        .frame(height: 30)
    }
}

private extension SwitchSettingsCellView {
    var switchable: some View {
        Toggle(isOn: option) {
            Text("")
        }
        .toggleStyle(SwitchToggleStyle(tint: .yellow))
        .onTapGesture {
            onChange.send(!option.wrappedValue)
        }
    }
}

//struct SwitchSettingsCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        SwitchSettingsCellView(option:, style: .commonWord)
//    }
//}
