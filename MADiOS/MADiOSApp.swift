//
//  MADiOSApp.swift
//  MADiOS
//
//  Created by Bram Rampelberg on 05/10/2024.
//

import SwiftUI
import SwiftData

@main
struct MADiOSApp: App {
    @StateObject private var globalNotificationViewModel = GlobalNotificationViewModel()
    @State private var networkMonitor = NetworkMonitor()
    
    var body: some Scene {
        WindowGroup {
            Navigation()
                .environmentObject(globalNotificationViewModel)
                .environment(networkMonitor)
        }
    }
}
