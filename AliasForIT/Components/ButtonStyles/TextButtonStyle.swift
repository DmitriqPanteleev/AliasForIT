//
//  TextButtonStyle.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 23.04.2024.
//

import SwiftUI

struct TextButtonStyle: ButtonStyle {
    
    @Environment(\.isEnabled) private var isEnabled
    
    @State private var isPressed = false
    
    let animationDuration: Double
    
    @ViewBuilder 
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(height: 54)
            .frame(maxWidth: .infinity)
            .background(content: background)
            .scaleEffect(x: isPressed ? 0.971 : 1, y: isPressed ? 0.983 : 1)
            .animation(.easeIn(duration: animationDuration), value: isPressed)
            .onChange(of: configuration.isPressed, perform: animate)
    }
}

private extension TextButtonStyle {
    func background() -> some View {
        (isEnabled ? Color.appDarkBlue : .appGray)
            .cornerRadius(.infinity)
    }
}

private extension TextButtonStyle {
    func animate(_ isPressed: Bool) {
        guard isPressed else {
            Task {
                try await Task.sleep(for: .seconds(animationDuration))
                self.isPressed = false
            }
            return
        }
        
        self.isPressed = true
    }
}

extension Button {
    func textButtonStyle(animationDuration: Double = 0.15, disabled: Bool = false) -> some View {
        self
            .buttonStyle(TextButtonStyle(animationDuration: animationDuration))
            .disabled(with: disabled)
    }
}
