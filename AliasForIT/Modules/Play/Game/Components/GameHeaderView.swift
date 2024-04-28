//
//  GameHeaderView.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 06.11.2023.
//

import SwiftUI

struct GameHeaderView: View {
    
    let tapAction: VoidCallback
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: tapAction) {
                Image(.close)
                    .resizable()
                    .frame(width: 12, height: 12)
                    .foregroundColor(.white)
                    .padding(12)
                    .background(Color.appDarkBlue)
                    .cornerRadius(12)
            }
        }
        .padding()
    }
}

struct GameHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            GameHeaderView(tapAction: {})
            Spacer()
        }
    }
}
