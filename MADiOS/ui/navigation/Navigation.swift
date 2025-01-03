//
//  Navigation.swift
//  MADiOS
//
//  Created by Bram Rampelberg on 01/01/2025.
//  Copyright © 2025 HOGENT. All rights reserved.
//

import SwiftUI

struct Navigation: View {
    @State var selectedPage = Page.calendar
    @StateObject var reservationsViewModel = ReservationsViewModel()
    
    var body: some View {
        TabView(selection: $selectedPage) {
            CalendarPage()
                .environmentObject(reservationsViewModel)
                .tabItem{
                    Label("Calendar", systemImage: "calendar")
                }.tag(Page.calendar)
            ReservationsPage().tabItem{
                Label("Notifications", systemImage: "bell")
            }.tag(Page.notifications)
            NotificationsPage().tabItem{
                Label("Profile", systemImage: "person.crop.circle.fill")
            }.tag(Page.profile)
        }
    }
}

enum Page: Hashable {
    case calendar
    case notifications
    case profile
}

#Preview {
    @Previewable @StateObject var reservationsViewModel = ReservationsViewModel()
    
    Navigation().environmentObject(reservationsViewModel)
}
