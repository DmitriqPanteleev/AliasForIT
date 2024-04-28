//
//  SwipableCardView.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 17.11.2022.
//

import SwiftUI
import Combine

struct SwipableCardView: View {
    
    let word: String
    let action: PassthroughSubject<Bool, Never>
    
    @State private var offset = CGSize.zero
    @State private var backgroundColor = Color.appBackground
    
    var body: some View {
        CardView(backgroundColor: $backgroundColor, word: word)
        .offset(x: offset.width, y: offset.height * 0.25)
        .rotationEffect(.degrees(Double(offset.width / 40)))
        .gesture (
            DragGesture(minimumDistance: 5)
                        .onEnded { (value) in
                            offset.width = value.translation.width
                            
                            switch value.translation.width {
                            case 0...30:
                                withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 100, damping: 12, initialVelocity: 0)) {
                                    offset.width = 0
                                }
                            case let x where x > 30:
                                withAnimation(.linear(duration: 0.5)) {
                                    offset.width = 500
                                    backgroundColor = .yellow
                                    action.send(true)
                                }
                            case (-30)...(-1):
                                withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 100, damping: 12, initialVelocity: 0)) {
                                    offset.width = 0
                                }
                            case let x where x < -30:
                                withAnimation(.linear(duration: 0.5)) {
                                    backgroundColor = .red
                                    offset.width  = -500
                                    action.send(false)
                                }
                            default:
                                withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 100, damping: 12, initialVelocity: 0)) {
                                    backgroundColor = .appBackground
                                    offset.width = 0
                                }
                            }
                        }
                )
    }
}



//struct SwipableCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        SwipableCardView(element: "It's me")
//    }
//}
