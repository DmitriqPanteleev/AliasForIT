//
//  Button+Extensions.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 21.10.2023.
//

import SwiftUI
import Combine

extension Button {
    init(publisher: PassthroughSubject<Void, Never>, label: () -> Label) {
        self.init(action: publisher.send, label: label)
    }
    
    init<T>(publisher: PassthroughSubject<T, Never>, model: T, label: () -> Label) {
        self.init(action: {
            publisher.send(model)
        }, label: label)
    }
}
