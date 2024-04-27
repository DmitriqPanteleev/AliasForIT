//
//  TeamEditable.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 21.04.2024.
//

import Foundation

protocol TeamEditable {
    func editName(_ name: String, by id: Identifier)
    func editPhoto(_ photo: TeamImage, by id: Identifier)
}
