//
//  Array+Extensions.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 02.05.2024.
//

import Foundation

extension Array where Element: Hashable {
    func unique() -> Self {
        Array(Set(self))
    }
}
