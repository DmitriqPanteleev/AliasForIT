//
//  PhotoChangeButtonStyle.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 05.11.2023.
//

import SwiftUI

struct PhotoChangeButtonStyle: ButtonStyle {
    
    @State private var isPressed = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(isPressed ? 0.8 : 1.0)
            .rotationEffect(.degrees(isPressed ? 15 : 0))
            .animation(.spring(), value: isPressed)
            .onChange(of: configuration.isPressed, perform: onPressed)
    }
    
    private func onPressed(_ isPressed: Bool) {
        if isPressed {
            self.isPressed = isPressed
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            if !isPressed {
                self.isPressed = false
            }
        }
    }
}

extension Button {
    func photoChangeButtonStyle() -> some View {
        self
            .buttonStyle(PhotoChangeButtonStyle())
    }
}
