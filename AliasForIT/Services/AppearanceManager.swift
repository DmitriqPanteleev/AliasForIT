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
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            
            
        }
    }
}
