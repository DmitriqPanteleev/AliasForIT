//
//  Typealiases.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 05.11.2023.
//

import Foundation
import Combine

// MARK: - Primitives
typealias Identifier = Int

// MARK: - Functions and closures
typealias VoidCallback = () -> Void
typealias StringCallback = (String) -> Void
typealias IdentifierCallback = (Identifier) -> Void
typealias CoordinateCallback = (CGFloat) -> Void

// MARK: - Combine
typealias IdentifierSubject = PassthroughSubject<Identifier, Never>
typealias VoidSubject = PassthroughSubject<Void, Never>
typealias StringSubject = PassthroughSubject<String, Never>
typealias BoolSubject = PassthroughSubject<Bool, Never>
typealias SettingSubject = PassthroughSubject<SettingItem, Never>
typealias TeamSubject = PassthroughSubject<TeamModel, Never>
typealias ImageSubject = PassthroughSubject<TeamImage, Never>
typealias IntSubject = PassthroughSubject<Int, Never>
typealias TeamSheetSubject = PassthroughSubject<TeamSheetConfig, Never>
