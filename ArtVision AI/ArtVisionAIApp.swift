//
//  ParkMateApp.swift
//  ParkMate
//
//  Created by Shadan Namazi on 2023-06-25.
//

import SwiftUI

@main
struct ArtVisionAI: App {
    @EnvironmentObject var profileManager: ProfileManager
    var body: some Scene {
        WindowGroup {
            
            LoginPage()
                .environmentObject(ProfileManager())
        }
    }
}
