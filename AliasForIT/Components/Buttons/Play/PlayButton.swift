//
//  PlayButton.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 06.11.2023.
//

import SwiftUI

struct PlayButton: View {
    
    @Environment(\.isEnabled) private var isEnabled
    
    let tapSubject: VoidSubject
    private let labelWidth: CGFloat = 24
    
    var body: some View {
        Button(subject: tapSubject) {
            Image(.playFill)
                .resizable()
                .scaledToFit()
                .frame(width: labelWidth)
                .foregroundColor(.white)
                .padding(.leading, labelWidth/4)
                .padding(labelWidth)
                .background(isEnabled
                            ? Color.appDarkBlue.cornerRadius(100)
                            : Color.appDarkGray.cornerRadius(100))
        }
        .scaleButtonStyle()
    }
}

struct PlayButton_Previews: PreviewProvider {
    static var previews: some View {
        PlayButton(tapSubject: VoidSubject())
    }
}
