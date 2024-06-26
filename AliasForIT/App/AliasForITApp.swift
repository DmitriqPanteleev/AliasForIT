//
//  AliasForITApp.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 15.11.2022.
//

import SwiftUI

@main
struct AliasForITApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            MainCoordinator().view()
        }
    }
}

// TODO: список задач
// 1. Добавить анимированный сплэш (отключить в дебаге)
// 2. Добавить скроллящийся онбординг (правила игры)
