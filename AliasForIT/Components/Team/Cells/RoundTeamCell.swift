//
//  RoundTeamCell.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 01.05.2024.
//

import SwiftUI

struct RoundTeamCell: View {
    
    let image: TeamImage
    let isSmall: Bool
    let isPaused: Bool
    let timerSubject: BoolSubject
    
    private var size: CGFloat {
        isSmall ? 86 : 172
    }
    
    var body: some View {
        Image(image)
            .resizable()
            .scaledToFill()
            .frame(width: size, height: size)
            .onTapGesture(perform: pause)
            .overlay {
                RoundedRectangle(cornerRadius: .infinity)
                    .stroke(Color.white, lineWidth: 4)
                    .frame(width: size + 4, height: size + 4)
            }
            .overlay(content: bottomPausedOverlay)
            .mask { Circle() }
    }
    
    @ViewBuilder
    func bottomPausedOverlay() -> some View {
        if isPaused {
            Color.white.opacity(0.5)
                .overlay {
                    Image(.pauseCircle)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 86, height: 86)
                        .foregroundColor(.appDarkBlue)
                }
                .onTapGesture(perform: start)
        }
    }
}

private extension RoundTeamCell {
    func start() {
        timerSubject.send(true)
    }
    
    func pause() {
        timerSubject.send(false)
    }
}

#Preview {
    RoundTeamCell(image: .elon, isSmall: true, isPaused: true, timerSubject: BoolSubject())
}
