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
    let settingsSubject: VoidSubject
    
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
    
    @ViewBuilder
    func settingsButtonView() -> some View {
        
        let buttonSize: CGFloat = 14
        
        Button(subject: settingsSubject) {
            Image(.addTeam)
                .resizable()
                .frame(width: buttonSize, height: buttonSize)
                .foregroundColor(.white)
                .padding(10)
                .background(Color.appDarkBlue.cornerRadius(buttonSize * 2))
        }
        .padding(6)
        .padding(.horizontal, 10)
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
