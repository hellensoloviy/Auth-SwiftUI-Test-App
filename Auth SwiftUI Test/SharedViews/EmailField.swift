//
//  EmailField.swift
//  Auth SwiftUI Test
//
//  Created by Hellen Soloviy on 15.01.2026.
//

import SwiftUI

#Preview {
    EmailField(value: .constant("hellen.ios@example.com"))
}

struct EmailField: View {
    
    @Binding var value: String
    var placeholder: String = "Email"
    
    var body: some View {
        TextField(placeholder, text: $value)
            .textFieldStyle(DefaultTextFieldStyle())
            .textInputAutocapitalization(.never)
            .textContentType(.emailAddress)
        
    }
}


