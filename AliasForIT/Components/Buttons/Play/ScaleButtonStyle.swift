//
//  ScaleButtonStyle.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 06.11.2023.
//

import SwiftUI

fileprivate enum PlayButtonState {
    case normal
    case pressed
    case unpressed
}

struct ScaleButtonStyle: ButtonStyle {
    
    @State private var isPressed = false
    private let animationDuration = 0.2
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(isPressed ? 0.85 : 1.0)
            .animation(.easeInOut(duration: animationDuration), value: isPressed)
            .onChange(of: configuration.isPressed, perform: onPressed)
        
    }
    
    private func onPressed(_ isPressed: Bool) {
        if isPressed {
            self.isPressed = true
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                self.isPressed = false
            }
        }
    }
}

extension Button {
    func scaleButtonStyle() -> some View {
        self
            .buttonStyle(ScaleButtonStyle())
    }
}
