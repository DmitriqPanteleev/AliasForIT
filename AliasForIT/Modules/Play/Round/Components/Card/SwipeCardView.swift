//
//  SwipeCardView.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 29.04.2024.
//

import SwiftUI

struct SwipeCardView: View {
    
    @State private var state: PlayCardState = .neutral
    @State private var offset = CGSize.zero
    
    let word: String
    let isFirst: Bool
    let action: BoolSubject
    
    var body: some View {
        PlayCardView(state: state, word: word, isFirst: isFirst)
            .offset(x: offset.width, y: offset.height * 0.25)
            .rotationEffect(.degrees(Double(offset.width / 40)))
            .scaleEffect(isFirst ? 1 : 0.85, anchor: .bottom)
            .offset(y: isFirst ? -16 : 0)
            .gesture (
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        let width = value.translation.width
                        
                        if ((-30)...(-20)).contains(width) {
                            withAnimation(.swipeAnimation) {
                                state = .missed
                                offset.width = -30
                                return
                            }
                        } else if (20...30).contains(width) {
                            withAnimation(.swipeAnimation) {
                                state = .guessed
                                offset.width = 30
                                return
                            }
                        }
                    }
                    .onEnded { value in
                        
                        offset.width = value.translation.width
                        
                        switch offset.width {
                        case 0...30, (-30)...(-1):
                            withAnimation(.returnAnimation) {
                                state = .neutral
                                onWordReturned()
                            }
                        case let x where x > 30:
                            withAnimation(.swipeAnimation) {
                                state = .guessed
                                onWordGuessed()
                            }
                        case let x where x < -30:
                            withAnimation(.swipeAnimation) {
                                state = .missed
                                onWordMissed()
                            }
                        default:
                            withAnimation(.returnAnimation) {
                                state = .neutral
                                onWordReturned()
                            }
                        }
                    }
            )
    }
}

private extension SwipeCardView {
    func onChangeOffset(_ value: CGFloat) {
        offset.width = value
    }
    
    func onWordGuessed() {
        offset.width = 500
        action.send(true)
    }
    
    func onWordMissed() {
        offset.width = -500
        action.send(false)
    }
    
    func onWordReturned() {
        offset.width = 0
    }
}

#Preview {
    SwipeCardView(word: "GCD",
                  isFirst: true,
                  action: BoolSubject())
}
