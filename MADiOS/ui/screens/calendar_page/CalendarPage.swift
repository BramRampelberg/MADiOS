//
//  ContentView.swift
//  MADiOS
//
//  Created by Bram Rampelberg on 05/10/2024.
//

import SwiftUI
import SwiftData
import SlidingTabView

struct CalendarPage: View {
    @State var selectedTab = 0
    
    var body: some View {
        VStack {
            SlidingTabView(selection: $selectedTab, tabs: ["Calendar", "Reservations"])
            MaximizedContainer {
                if selectedTab == 0 {
                    Calendar()
                }
                if selectedTab == 1 {
                    ReservationsPage()
                }
            }
        }
    }
}

enum Tab: Hashable {
    case calendar
    case reservations
}

#Preview {
    CalendarPage()
}
