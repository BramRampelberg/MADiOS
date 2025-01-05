//
//  ProfilePage.swift
//  MADiOS
//
//  Created by Bram Rampelberg on 03/01/2025.
//  Copyright © 2025 HOGENT. All rights reserved.
//

import SwiftUI

struct ProfilePage: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    private var maxWidth: CGFloat = 600
    
    var body: some View {
        MaximizedContainer {
            VStack{
                Text("name").bold().font(.title)
                Text("email")
                    .padding(.bottom, 24)
                buttonsCard
                    .padding(.bottom, 24)
                logoutButton
            }
            .padding(24)
        }.background(Color(hex: "F2F2F7"))
    }
    
    var editButton: some View {
        HStack {
            Image(systemName: "pencil")
            Button("Edit profile"){
                
            }
            .disabled(true)
        }
    }
    
    var settingsButton: some View {
        HStack {
            Image(systemName: "gearshape.fill")
            Button("Settings"){
                
            }
            .disabled(true)
        }
    }
    
    var buttonsCard: some View {
        VStack (alignment: .leading){
            editButton
            settingsButton
        }
        .font(.title2)
        .frame(minWidth: 0, maxWidth: maxWidth)
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .gray, radius: 1, x: 0, y: 1)
    }
    
    var logoutButton: some View {
        Button(action: {
            loginViewModel.logout()
        }){
            HStack{
                Image(systemName: "rectangle.portrait.and.arrow.right")
                Text("Log out")
            }.frame(minWidth: 0, maxWidth: maxWidth)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: .infinity).stroke(.gray, lineWidth: 1))
        .foregroundColor(.black)
    }
}

#Preview {
    ProfilePage()
}
