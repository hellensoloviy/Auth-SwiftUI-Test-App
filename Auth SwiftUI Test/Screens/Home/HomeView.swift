//
//  HomeView.swift
//  Auth SwiftUI Test
//
//  Created by Hellen Soloviy on 15.01.2026.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            
            Spacer()
            
            Text("Info example text")
                .font(.caption)
                .multilineTextAlignment(.center)
                .padding(.bottom, 10)
            
            Button("Fetch security data") {
                
            }
            .padding(.bottom, 10)
            
            Button("Reset") {
                
            }
            
            Spacer()
            Button("Logout") {
                
            }
            .padding(.bottom, 10)
            .foregroundStyle(.brown)
            .bold()

        }
        .navigationTitle("Home screen")
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    HomeView()
}
