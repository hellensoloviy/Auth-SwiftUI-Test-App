//
//  PasswordField.swift
//  Auth SwiftUI Test
//
//  Created by Hellen Soloviy on 15.01.2026.
//

import SwiftUI

struct PasswordField: View {
    
    @Binding var value: String
    var placeholder: String = "Password"
    
    var body: some View {
        SecureField(placeholder, text: $value)
            .textFieldStyle(DefaultTextFieldStyle())
            .textInputAutocapitalization(.never) //TODO: check if already in SecureField
    }
}

#Preview {
    PasswordField(value: .constant("Example123@"))
}
