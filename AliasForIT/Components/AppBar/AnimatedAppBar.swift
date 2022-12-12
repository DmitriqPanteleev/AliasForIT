//
//  AnimatedAppBar.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 09.12.2022.
//

import SwiftUI

struct AnimatedAppBar: View {
    
    let title: String
    let subtitle: String
    
    var body: some View {
        appBar
    }
}

private extension AnimatedAppBar {
    
    var appBar: some View {
        
        GeometryReader { proxy in
            
            let minY = proxy.frame(in: .named("header")).minY
            let size = proxy.size
            
            VStack(alignment: .leading) {
                Text(title)
                    .animatedTitle(fontSize: min(27, 27 + CGFloat(minY / 2)))
                    .opacity(minY <= -0.5 ? 1 / (-minY * 0.5) : 1)
                    .padding(.bottom, minY <= -0.5 * 2 ? minY : 10)
                
                Text(subtitle)
                    .animatedTitle(fontSize: min(21, 21 + CGFloat(minY / 2)))
                    .opacity(minY <= -0.5 ? 1 / (-minY * 3) : 1)
            }
            .padding(.top, minY + 16)
            .frame(width: size.width, height: size.height, alignment: .topLeading)
            .offset(y: -minY + 16)
        }
    }
}

struct AnimatedAppBar_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedAppBar(title: "Large Title", subtitle: "Some text about score")
    }
}
