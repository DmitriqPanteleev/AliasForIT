//
//  MainHeader.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 21.10.2023.
//

import SwiftUI
import Combine

struct MainHeader: View {
//    let mode: String = "Классический режим" // не в рамках MVP
    let addTeamSubject: VoidSubject
    
    var body: some View {
        HStack {
            titleView
            Spacer()
            addTeamButtonView
        }
        .padding(.leading)
    }
}

private extension MainHeader {
    var titleView: some View {
        Text("Новая игра")
            .foregroundColor(.appDarkBlue)
            .font(.system(size: 28))
    }
    
    @ViewBuilder
    var addTeamButtonView: some View {
        
        let buttonSize: CGFloat = 14
        
        Button(action: addTeamSubject.send) {
            Image(.addTeam)
                .resizable()
                .frame(width: buttonSize, height: buttonSize)
                .foregroundColor(.white)
                .padding(10)
                .background(Color.appDarkBlue.cornerRadius(buttonSize * 2))
        }
        .scaledButtonStyle()
        .padding(6)
        .padding(.horizontal, 10)
    }
}

#if DEBUG
struct MainHeader_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MainHeader(addTeamSubject: PassthroughSubject<Void, Never>())
            Spacer()
        }
    }
}
#endif
