//
//  AppearanceManager.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 09.12.2022.
//

import UIKit

final class AppearanceManager {
    
    static func start() {
        setupNavigationBar()
    }
    
    private static func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
