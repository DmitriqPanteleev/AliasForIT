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

extension View {
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorners(radius: radius, corners: corners) )
    }
}

struct RoundedCorners: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
