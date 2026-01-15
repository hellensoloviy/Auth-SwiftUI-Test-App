//
//  MainButtonStyle.swift
//  Auth SwiftUI Test
//
//  Created by Hellen Soloviy on 15.01.2026.
//

import SwiftUI

#Preview {
    Button("Test Button") {
        
    }
    .buttonStyle(MainButtonStyle())
    .padding()
}

struct MainButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 10)
            .padding(.horizontal, 50)
            .frame(maxWidth: .infinity)
            .background(Color.orange.opacity(0.7))
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(.smooth, value: configuration.isPressed)
            .shadow(color: .white, radius: 2)

    }
    
}

