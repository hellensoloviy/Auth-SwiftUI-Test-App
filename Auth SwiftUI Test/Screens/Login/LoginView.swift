//
//  LoginView.swift
//  Auth SwiftUI Test
//
//  Created by Hellen Soloviy on 15.01.2026.
//

import SwiftUI

#Preview {
    LoginView()
}

struct LoginView: View {
    
    var body: some View {
        VStack {
            
            Spacer()
            EmailField(value: .constant("text.email@email.com"))
                .padding(.bottom, 10)

            PasswordField(value: .constant("text13455"))
                .padding(.bottom, 10)
            
            Button("Login".uppercased()) {
                
            }
            .foregroundStyle(.green)
            .bold()
            
            Spacer()
            Button("Register") {
                
            }
        }
        .padding(.horizontal, 50)
        .navigationTitle("Login")
    }
    
}


