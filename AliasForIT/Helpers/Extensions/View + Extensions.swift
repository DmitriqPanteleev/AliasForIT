//
//  View + Extensions.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 17.11.2022.
//

import SwiftUI
import Combine

extension View {
    
    @ViewBuilder func `if`<Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View {
        if condition() {
            transform(self)
        } else {
            self
        }
    }
    
    public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
             let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
             return clipShape(roundedRect)
                  .overlay(roundedRect.strokeBorder(content, lineWidth: width))
         }
    
    public func gradientForeground(colors: [Color], startPoint: UnitPoint, endPoint: UnitPoint) -> some View {
        self.overlay(
            LinearGradient(
                colors: colors,
                startPoint: startPoint,
                endPoint: endPoint)
        )
            .mask(self)
    }
}
