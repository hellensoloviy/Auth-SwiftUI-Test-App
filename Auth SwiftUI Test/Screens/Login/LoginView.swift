//
//  LoginView.swift
//  Auth SwiftUI Test
//
//  Created by Hellen Soloviy on 15.01.2026.
//

import SwiftUI

#Preview {
    LoginView(viewModel: .init())
}

struct LoginView: View {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            
            Spacer()
            EmailField(value: $viewModel.email)
                .padding(.bottom, 10)

            PasswordField(value: $viewModel.password)
                .padding(.bottom, 10)
            
            Button("Login".uppercased()) {
                viewModel.onLoginUserAction()
            }
            .buttonStyle(MainButtonStyle())

            
            Spacer()
            Button("Register") {
                viewModel.onRegisterUserAction()
            }
            
        }
        .padding(.horizontal, 50)
        .navigationTitle("Login")
    }
    
}


