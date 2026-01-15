//
//  RegisterView.swift
//  Auth SwiftUI Test
//
//  Created by Hellen Soloviy on 15.01.2026.
//

import SwiftUI

struct RegisterView: View {
    var body: some View {
        
        VStack {
            Spacer()
            EmailField(value: .constant("text.email@email.com"))
                .padding(.bottom, 10)
            PasswordField(value: .constant("text13455"))
                .padding(.bottom, 10)
            PasswordField(value: .constant("text13455"), placeholder: "Confirm Password")
                .padding(.bottom, 10)
            
            
            Button("Register".uppercased()) {
                
            }
            .foregroundStyle(.green)
            .bold()
            
            Spacer()
            Button("Login") {
                
            }
        }
        .padding(.horizontal, 50)
        .navigationTitle("Register")
    }
}

#Preview {
    RegisterView()
}
