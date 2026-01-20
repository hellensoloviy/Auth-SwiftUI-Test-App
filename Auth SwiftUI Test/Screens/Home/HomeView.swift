//
//  HomeView.swift
//  Auth SwiftUI Test
//
//  Created by Hellen Soloviy on 15.01.2026.
//

import SwiftUI


#Preview {
    HomeView(viewModel: .init(networkHandler: .init(), tokenStorage: .init()))
}

struct HomeView: View {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Text(viewModel.infoText) //TODO: - why error with $viewModel. Check if updated, because its binding
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.bottom, 10)
            
            Button("Fetch security data") {
                viewModel.onFetchAction()
            }
            .padding(.bottom, 10)
            .buttonStyle(MainButtonStyle())

            
            Button("Reset") {
                viewModel.onResetInfoText()
            }

            
            Spacer()
            Button("Logout") {
                viewModel.onLogoutUserAction()
            }
            .buttonStyle(MainButtonStyle())
            .padding()


        }
        .navigationTitle("Home screen")
        .navigationBarBackButtonHidden()
        .padding(.horizontal, 50)
        .alert(viewModel.alertTitle, isPresented: $viewModel.showAlert) {
            Button("Ok", role: .cancel, action: { /* nothing needed additionally  */})
        } message: {
            Text(viewModel.alertMessage)
        }
    }
}

