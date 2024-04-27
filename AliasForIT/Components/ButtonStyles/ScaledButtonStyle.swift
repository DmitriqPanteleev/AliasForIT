//
//  ScaledButtonStyle.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 24.04.2024.
//

import SwiftUI

struct ScaledButtonStyle: ButtonStyle {
    
    @Environment(\.isEnabled) private var isEnabled
    
    @State private var isPressed = false
    
    let animationDuration: Double
    
    @ViewBuilder
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(x: isPressed ? 0.5 : 1, y: isPressed ? 0.5 : 1)
            .animation(.easeIn(duration: animationDuration), value: isPressed)
            .onChange(of: configuration.isPressed, perform: animate)
    }
}

private extension ScaledButtonStyle {
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
    func scaledButtonStyle(animationDuration: Double = 0.15, disabled: Bool = false) -> some View {
        self
            .buttonStyle(ScaledButtonStyle(animationDuration: animationDuration))
            .disabled(with: disabled)
    }
}
