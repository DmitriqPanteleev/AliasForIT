//
//  RoundTimerView.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 29.04.2024.
//

import SwiftUI

struct RoundTimerView: View {
    
    @Environment(\.screenSize) private var screenSize
    
    let time: Int
    let totalTime: Int
    var width: CGFloat {
        screenSize.width - 64
    }
    
    var body: some View {
        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: .infinity)
                .fill(Color.appGray)
                .frame(width: width, height: 4)
                .overlay(alignment: .leading) {
                    RoundedRectangle(cornerRadius: .infinity)
                        .fill(Color.appDarkGray)
                        .frame(width: width * (CGFloat(time) / CGFloat(totalTime)),
                               height: 4)
                        .animation(.linear, value: time)
                }
            
            Text(String(time))
                .playTimer(.appDarkBlue)
        }
    }
}

#Preview {
    RoundTimerView(time: 30, totalTime: 60)
}
