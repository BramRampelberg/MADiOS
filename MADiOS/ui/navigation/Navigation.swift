//
//  Navigation.swift
//  MADiOS
//
//  Created by Bram Rampelberg on 01/01/2025.
//  Copyright © 2025 HOGENT. All rights reserved.
//

import SwiftUI

struct Navigation: View {
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @StateObject private var loginViewModel = LoginViewModel()
    @State var selectedPage = Page.calendar
    @State private var isLoggedIn = false
    
    var body: some View {
        VStack{
            if (!isLoggedIn){
                LoginPage().environmentObject(loginViewModel).transition(.move(edge: .leading))
            } else {
                if verticalSizeClass == .compact {
                    HStack{
                        sidebar
                        MaximizedContainer {
                            switch selectedPage {
                            case .calendar:
                                CalendarPage()
                            case .notifications:
                                NotificationsPage()
                            case .profile:
                                ProfilePage()
                            }
                        }
                    }.ignoresSafeArea(edges: .leading)
                    
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
    
    private var sidebar: some View {
        List {
            Button {
                selectedPage = .calendar
            } label: {
                Label("Calendar", systemImage: "calendar")
            }
            .buttonStyle(.plain)
            .listRowBackground(selectedPage == .calendar ? Color.gray.opacity(0.2) : Color.clear)
            
            Button {
                selectedPage = .notifications
            } label: {
                Label("Notifications", systemImage: "bell")
            }
            .buttonStyle(.plain)
            .listRowBackground(selectedPage == .notifications ? Color.gray.opacity(0.2) : Color.clear)
            
            Button {
                selectedPage = .profile
            } label: {
                Label("Profile", systemImage: "person.crop.circle.fill")
            }
            .buttonStyle(.plain)
            .listRowBackground(selectedPage == .profile ? Color.gray.opacity(0.2) : Color.clear)
        }
        .listStyle(SidebarListStyle())
        .frame(maxWidth: 225)
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
