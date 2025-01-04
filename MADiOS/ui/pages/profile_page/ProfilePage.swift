//
//  ProfilePage.swift
//  MADiOS
//
//  Created by Bram Rampelberg on 03/01/2025.
//  Copyright © 2025 HOGENT. All rights reserved.
//

import SwiftUI

struct ProfilePage: View {
    
    var body: some View {
        VStack{
            Text("name").bold().font(.title)
            Text("email")
                .padding(.bottom, 24)
            ButtonsCard()
                .padding(.bottom, 24)
            LogoutButton()
        }
        .padding(24)
    }
    
    struct EditButton: View {
        var body: some View {
            HStack {
                Image(systemName: "pencil")
                Button("Edit profile"){
                    
                }
                .disabled(true)
            }
        }
    }
    
    struct SettingsButton: View {
        var body: some View {
            HStack {
                Image(systemName: "gearshape.fill")
                Button("Settings"){
                    
                }
                .disabled(true)
            }
        }
    }

    struct ButtonsCard: View {
        var body: some View {
            VStack (alignment: .leading){
                EditButton()
                SettingsButton()
            }
            .font(.title2)
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .gray, radius: 1.5, x: 0, y: 1)
        }
    }

    struct LogoutButton: View {
        @EnvironmentObject var loginViewModel: LoginViewModel
        
        var body: some View {
            Button(action: {
                loginViewModel.logout()
            }){
                HStack{
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                    Text("Log out")
                }.frame(minWidth: 0, maxWidth: .infinity)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: .infinity).stroke(.gray, lineWidth: 1))
            .foregroundColor(.black)
        }
    }
}

#Preview {
    ProfilePage()
}
