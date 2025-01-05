//
//  GlobalNotification.swift
//  MADiOS
//
//  Created by Bram Rampelberg on 05/01/2025.
//  Copyright © 2025 HOGENT. All rights reserved.
//

import SwiftUI

struct GlobalNotification: View {
    @EnvironmentObject var globalNotificationViewModel: GlobalNotificationViewModel
    @Environment(NetworkMonitor.self) private var networkMonitor
    
    var body: some View {
        if !networkMonitor.isConnected {
            HStack {
                Notification(notification: "No Internet connection")
                Image(systemName: "wifi.slash")
            }
            .padding()
            .foregroundColor(.white)
            .contentShape(Rectangle()).background(Colors.red)
        }
        if globalNotificationViewModel.hasNotification {
            Notification(notification: globalNotificationViewModel.notification!)
                .padding()
                .foregroundColor(.white)
                .contentShape(Rectangle()).background(Colors.red)
        }
    }
    
    struct Notification: View {
        let notification: String
        
        var body: some View {
            HStack {
                Text(notification)
                    .font(.title)
                    .bold()
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
        }
    }

}

#Preview {
    GlobalNotification()
}

