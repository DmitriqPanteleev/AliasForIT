//
//  LinearProgressView.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 02.12.2022.
//

import SwiftUI

struct LinearProgressView: View {
    
    @Binding var progress: Int
    let total: Int
    
    var body: some View {
        ProgressView(value: Double(progress), total: Double(total))
            .tint(.yellow)
    }
}

//struct LinearProgressView_Previews: PreviewProvider {
//    static var previews: some View {
//        LinearProgressView(progress: 30)
//    }
//}
