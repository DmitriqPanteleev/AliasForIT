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
            SettingsView(viewModel: SettingsViewModel())
            RoundView(viewModel: RoundViewModel(
                roundModel: RoundModel(
                    team: TeamModel(
                        name: "name",
                        image: "",
                        score: 10
                    ),
                    words: [:]
                ),
                roundDuration: UserStorage.shared.roundTime)
            )
        }
    }
}
