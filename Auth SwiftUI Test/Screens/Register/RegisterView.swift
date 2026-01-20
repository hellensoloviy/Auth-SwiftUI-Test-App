//
//  RegisterView.swift
//  Auth SwiftUI Test
//
//  Created by Hellen Soloviy on 15.01.2026.
//

import SwiftUI

#Preview {
    RegisterView(viewModel: .init(networkHandler: .init()))
}

struct RegisterView: View {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        
        VStack {
            Spacer()
            EmailField(value: $viewModel.email)
                .padding(.bottom, 10)
            PasswordField(value: $viewModel.password)
                .padding(.bottom, 10)
            PasswordField(value: $viewModel.confirmPassword, placeholder: "Confirm Password")
                .padding(.bottom, 10)
            
            
            Button("Register".uppercased()) {
                viewModel.onRegisterUserAction()
            }
            .buttonStyle(MainButtonStyle())
            
            Spacer()
            Button("Login") {
                viewModel.onLoginUserAction()
            }
            
        }
        .padding(.horizontal, 50)
        .navigationTitle("Register")
        .alert(viewModel.alertTitle, isPresented: $viewModel.showAlert) {
            Button("Ok", role: .cancel, action: {
                viewModel.handleRegistrationResult()
            })
        } message: {
            Text(viewModel.alertMessage)
        }
    }
}


