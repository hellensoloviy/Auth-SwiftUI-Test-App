//
//  DefaultTextFieldStyle.swift
//  Auth SwiftUI Test
//
//  Created by Hellen Soloviy on 15.01.2026.
//

import SwiftUI

#Preview {
    TextField("Placeholder", text: .constant("Value"))
        .textFieldStyle(DefaultTextFieldStyle())
        .padding()
    
}

struct DefaultTextFieldStyle: TextFieldStyle {
    
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .padding(.horizontal, 5)
            .padding(.vertical, 10)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.black, lineWidth: 1)
            }
    }
    
}
