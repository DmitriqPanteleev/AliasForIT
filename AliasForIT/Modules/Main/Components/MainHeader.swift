//
//  MainHeader.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 21.10.2023.
//

import SwiftUI
import Combine

struct MainHeader: View {
    
    let mode: String = "Классический режим"
    let settingsSubject: PassthroughSubject<Void, Never>
    
    var body: some View {
        HStack(alignment: .top) {
            titleView()
            Spacer()
            settingsButtonView()
        }
        .padding(.leading)
    }
}

private extension MainHeader {
    func titleView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Новая игра")
                .foregroundColor(.appDarkBlue)
                .font(.system(size: 28))
            Text(mode)
                .foregroundColor(.appDarkGray)
                .font(.system(size: 16, weight: .thin))
        }
    }
    
    func settingsButtonView() -> some View {
        Button(publisher: settingsSubject) {
            Image(.settings)
                .resizable()
                .frame(width: 22, height: 22)
        }
        .padding(6)
        .tint(.appDarkBlue)
    }
}

#if DEBUG
struct MainHeader_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MainHeader(settingsSubject: PassthroughSubject<Void, Never>())
            Spacer()
        }
    }
}
#endif
