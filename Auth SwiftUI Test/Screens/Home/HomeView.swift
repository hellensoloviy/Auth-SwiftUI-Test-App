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
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.bottom, 10)
            
            Button("Fetch security data") {
                
            }
            .padding(.bottom, 10)
            .buttonStyle(MainButtonStyle())

            
            Button("Reset") {
                
            }

            
            Spacer()
            Button("Logout") {
                
            }
            .buttonStyle(MainButtonStyle())
            .padding()


        }
        .navigationTitle("Home screen")
        .navigationBarBackButtonHidden()
        .padding(.horizontal, 50)

    }
}

#Preview {
    HomeView()
}
