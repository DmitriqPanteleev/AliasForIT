//
//  View + Extensions.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 17.11.2022.
//

import SwiftUI
import Combine

// TODO: DELETE
extension View {
    func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
             let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
             return clipShape(roundedRect)
                  .overlay(roundedRect.strokeBorder(content, lineWidth: width))
         }
    
    func gradientForeground(colors: [Color], startPoint: UnitPoint, endPoint: UnitPoint) -> some View {
        self.overlay(
            LinearGradient(
                colors: colors,
                startPoint: startPoint,
                endPoint: endPoint)
        )
            .mask(self)
    }
}

// MARK: - Corners
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

// MARK: - Transitions & Animations
extension View {
    func scaleTransition<V: Equatable>(from direction: UnitPoint, _ value: V) -> some View {
        self
            .animation(.bouncy, value: value)
            .transition(.opacity.combined(with: .scale(scale: 0.5, anchor: direction)).animation(.smooth))
    }
    
    func disabled(with value: Bool) -> some View {
        self
            .disabled(value)
            .animation(.smooth, value: value)
    }
}

// MARK: - BS Settings
extension View {
    func settingsSheetPresentation(height: CGFloat) -> some View {
        self
            .presentationDetents([.height(height)])
            .presentationDragIndicator(.visible)
            .presentationContentInteraction(.resizes)
            .presentationBackground(Color.appLightGray)
    }
}
