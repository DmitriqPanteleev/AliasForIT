//
//  CountSettingCellView.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 15.11.2022.
//

import SwiftUI
import Combine

struct CountSettingCellView: View {
    
    let option: Int
    let style: SettingsCellStyle
    let onChange: PassthroughSubject<Int, Never>
    
    var body: some View {
        HStack {
            Image(systemName: style.icon)
                .padding(.trailing)
                .foregroundColor(.yellow)
            Text(style.title)
                .foregroundColor(.white)
            Spacer()
            counter
        }
        .frame(height: 30)
    }
}

private extension CountSettingCellView {
    var counter: some View {
        HStack(spacing: 10) {
            
            Image(systemName: "minus")
                .foregroundColor(.yellow)
                .background(Circle().frame(width: 30, height: 30).foregroundColor(.appBackground))
                .onTapGesture(perform: decrement)
            
            Text(String(option))
                .foregroundColor(.yellow)
            
            Image(systemName: "plus")
                .foregroundColor(.yellow)
                .background(Circle().frame(width: 30, height: 30).foregroundColor(.appBackground))
                .onTapGesture(perform: increment)
        }
    }
}

private extension CountSettingCellView {
    func increment() {
        onChange.send(10)
    }
    
    func decrement() {
        onChange.send(-10)
    }
}

//struct CountSettingCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        CountSettingCellView(option: 10, style: .points)
//    }
//}
