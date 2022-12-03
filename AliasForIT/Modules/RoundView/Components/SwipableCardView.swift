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
    @State private var backgroundColor = Color.black
    
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
                                withAnimation(.linear(duration: 0.3)) {
                                    offset.width = 500
                                    backgroundColor = .yellow
                                    action.send(true)
                                }
                            case (-30)...(-1):
                                withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 100, damping: 12, initialVelocity: 0)) {
                                    offset.width = 0
                                }
                            case let x where x < -30:
                                withAnimation(.linear(duration: 0.3)) {
                                    backgroundColor = .red
                                    offset.width  = -500
                                    action.send(false)
                                }
                            default:
                                withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 100, damping: 12, initialVelocity: 0)) {
                                    backgroundColor = .black
                                    offset.width = 0
                                }
                            }
                        }
                )
//        .gesture(
//            DragGesture(minimumDistance: 5)
//                .onChanged { gesture in
//                    offset = gesture.translation
//
//                    withAnimation {
//                        changeColor(width: offset.width)
//                    }
//                } .onEnded { _ in
//                    withAnimation {
//                        swipeCard(width: offset.width)
//                    }
//                }
//        )
    }
}

//private extension SwipableCardView {
//
//    func changeColor(width: CGFloat) {
//        switch width {
//        case -500...(-30):
//            backgroundColor = .red
//        case 30...500:
//            backgroundColor = .yellow
//        default:
//            backgroundColor = .black
//        }
//    }
//
//    func swipeCard(width: CGFloat) {
//        switch width {
//        case -500...(-30):
//            viewModel.input.answer.send(true)
//            offset = CGSize(width: -500, height: 0)
//        case 30...500:
//            viewModel.input.answer.send(false)
//            offset = CGSize(width: 500, height: 0)
//        default: offset = .zero
//        }
//    }
//}

//extension CGPoint {
//    func distance(to point: CGPoint) -> CGFloat {
//        return sqrt(pow((point.x - x), 2) + pow((point.y - y), 2))
//    }
//}

//struct SwipableCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        SwipableCardView(element: "It's me")
//    }
//}
