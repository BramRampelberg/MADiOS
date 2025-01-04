//
//  Navigation.swift
//  MADiOS
//
//  Created by Bram Rampelberg on 01/01/2025.
//  Copyright © 2025 HOGENT. All rights reserved.
//

import SwiftUI

struct Navigation: View {
    @StateObject var loginViewModel = LoginViewModel()
    @State var selectedPage = Page.calendar
    @State private var isLoggedIn = false
    
    var body: some View {
        VStack{
            if (!isLoggedIn){
                LoginPage().environmentObject(loginViewModel).transition(.move(edge: .leading))
            } else {
                TabView(selection: $selectedPage) {
                    CalendarPage()
                        .tabItem{
                            Label("Calendar", systemImage: "calendar")
                        }.tag(Page.calendar)
                    NotificationsPage().tabItem{
                        Label("Notifications", systemImage: "bell")
                    }.tag(Page.notifications)
                    ProfilePage().environmentObject(loginViewModel).tabItem{
                        Label("Profile", systemImage: "person.crop.circle.fill")
                    }.tag(Page.profile)
                }.transition(.move(edge: .trailing))
            }
        }
        .onAppear {
            isLoggedIn = loginViewModel.loginState.isLoggedIn
        }
        .onChange(of: loginViewModel.loginState.isLoggedIn){ _, newState in
            withAnimation {
                self.isLoggedIn = newState
                selectedPage = .calendar
            }
        }
    }
}

enum Page: Hashable {
    case calendar
    case notifications
    case profile
}

#Preview {
    Navigation()
}
