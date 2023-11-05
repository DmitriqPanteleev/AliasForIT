//
//  Button+Extensions.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 21.10.2023.
//

import SwiftUI
import Combine

extension Button {
    init(subject: VoidSubject, label: () -> Label) {
        self.init(action: subject.send, label: label)
    }
    
    init<T>(subject: PassthroughSubject<T, Never>, model: T, label: () -> Label) {
        self.init(action: {
            subject.send(model)
        }, label: label)
    }
}
