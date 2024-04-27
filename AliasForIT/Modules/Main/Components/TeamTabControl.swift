//
//  TeamTabControl.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 21.10.2023.
//

import SwiftUI

struct TeamTabControl: View {
    
    @Binding var selectedTeam: Int
    let teamCount: Int
    
    var body: some View {
        HStack(spacing: 12) {
            ForEach(0..<teamCount, id: \.hashValue, content: teamTab)
        }
    }
}

private extension TeamTabControl {
    func teamTab(_ index: Int) -> some View {
        RoundedRectangle(cornerRadius: 18)
            .frame(width: 36, height: 4)
            .foregroundColor(selectedTeam == index ? .appDarkBlue : .appGray)
    }
}

struct TeamTabControl_Previews: PreviewProvider {
    static var previews: some View {
        TeamTabControl(selectedTeam: .constant(0),
                       teamCount: 3)
    }
}
