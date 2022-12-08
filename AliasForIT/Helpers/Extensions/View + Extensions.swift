//
//  View + Extensions.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 17.11.2022.
//

import Foundation
import SwiftUI

extension View {
    public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
             let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
             return clipShape(roundedRect)
                  .overlay(roundedRect.strokeBorder(content, lineWidth: width))
         }
}
