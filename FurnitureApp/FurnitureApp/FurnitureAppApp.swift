//
//  FurnitureAppApp.swift
//  FurnitureApp
//
//  Created by Ilya Zelkin on 25.05.2022.
//

import SwiftUI

@main
struct FurnitureAppApp: App {
    @StateObject var placementSettings = PlacementSettings()
    @StateObject var sessionSettings = SessionSettings()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(placementSettings)
                .environmentObject(sessionSettings)
        }
    }
}
