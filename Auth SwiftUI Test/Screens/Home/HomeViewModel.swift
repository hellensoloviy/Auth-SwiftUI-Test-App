//
//  HomeViewModel.swift
//  Auth SwiftUI Test
//
//  Created by Hellen Soloviy on 15.01.2026.
//

import Combine
import SwiftUI

protocol HomeViewNavigationDelegate: AnyObject {
    func onLogout()
}

extension HomeView {
    
    class ViewModel: ObservableObject {
        let defaultText = "Please Tap Fetch Button to fetch needed data."
        
        @Published var infoText: String = ""
        
        @Published var showAlert: Bool = false
        var alertTitle: String = ""
        var alertMessage: String = ""
        
        weak var navigationDelegate: HomeViewNavigationDelegate?
        
        //MARK: - Private
        
        private let networkHandler: NetworkHandler
        private let tokenStorage: AccessTokenStorage
        
        //MARK: -
        
        init(networkHandler: NetworkHandler, tokenStorage: AccessTokenStorage) {
            self.networkHandler = networkHandler
            self.tokenStorage = tokenStorage
        }
        
    }
    
}

//MARK: - Actions
extension HomeView.ViewModel {
    
    func onLogoutUserAction() {
        navigationDelegate?.onLogout()
    }
    
    func onResetInfoText() {
        infoText = defaultText
    }
    
    func onFetchAction() {
        
        let route = NetworkRoutes.login
        guard let url = route.url, let accessString = tokenStorage.get()?.accessToken else {
            alertTitle = "Error Occured!"
            alertMessage = "Can't configure the request."
            showAlert = true
            
            return
        }
        
        
        Task {
            do {
                let responseData = try await networkHandler.reuest(url,
                                                                   responseType: SecureFetchData.self,
                                                                   method: route.method.rawValue,
                                                                   accessToken: accessString)
                
                await MainActor.run { [weak self] in
                    self?.infoText = responseData.message
                }
                
            } catch {
                await MainActor.run { [weak self] in
                    self?.infoText = error.localizedDescription
                }
            }
            
        }
    }
    
}
