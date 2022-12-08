//
//  Text + Extensions.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 06.12.2022.
//

import SwiftUI

extension Text {
    
    func titleWhite() -> Text {
        self
            .font(.system(size: 27, weight: .regular))
            .foregroundColor(.white)
    }
    
    func titleTwoWhite() -> Text {
        self
            .font(.system(size: 21, weight: .regular))
            .foregroundColor(.white)
    }
    
    func titleTwoYellow() -> Text {
        self
            .font(.system(size: 21, weight: .regular))
            .foregroundColor(.yellow)
    }
    
    func titleThreeWhite() -> Text {
        self
            .font(.system(size: 18, weight: .semibold))
            .foregroundColor(.white)
    }
}
