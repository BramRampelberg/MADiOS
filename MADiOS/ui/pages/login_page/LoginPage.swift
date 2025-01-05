//
//  LoginPage.swift
//  MADiOS
//
//  Created by Bram Rampelberg on 03/01/2025.
//  Copyright © 2025 HOGENT. All rights reserved.
//

import SwiftUI

struct LoginPage: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    @State private var isPasswordVisible: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            buutLogo
            loginForm
            if (loginViewModel.loginState.isLoading) {
                ProgressView()
            }
            if (loginViewModel.loginState.hasError) {
                Text(loginViewModel.loginState.errorDescription!).padding(.horizontal, 20).foregroundColor(Colors.red)
            }
            loginButton
            Spacer()
        }
        .background(Rectangle().fill(Colors.primary).ignoresSafeArea())
    }
    
    var buutLogo: some View {
        Image(.buutLogoWhite)
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100)
    }
    
    var loginForm: some View {
        Form{
            Section (header: Text("Login").bold().font(.title).foregroundColor(.white)) {
                TextField("Email", text: $loginViewModel.email)
                HStack {
                    if isPasswordVisible {
                        TextField("Password", text: $loginViewModel.password)
                    }
                    else {
                        SecureField("Password", text: $loginViewModel.password)
                    }
                    Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(.gray)
                        .onTapGesture {
                            isPasswordVisible.toggle()
                        }
                }
            }
        }
        .scrollContentBackground(.hidden)
        .frame(height: 175)
    }
    
    var loginButton: some View {
        Button(action: {
            withAnimation (.easeIn(duration: 0.5)) {
                loginViewModel.login()
            }
        }) {
            Text("Login").frame(minWidth: 0, maxWidth: .infinity)
        }
        .disabled(loginViewModel.loginState.isLoading)
        .padding()
        .background(RoundedRectangle(cornerRadius: .infinity).stroke(.white, lineWidth: 1))
        .padding(20)
        .foregroundColor(.white)
    }
}

#Preview {
    @Previewable @StateObject var loginViewModel = LoginViewModel()
    
    LoginPage().environmentObject(loginViewModel)
}
