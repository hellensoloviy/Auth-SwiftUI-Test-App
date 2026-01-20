//
//  LoginViewModel.swift
//  Auth SwiftUI Test
//
//  Created by Hellen Soloviy on 15.01.2026.
//

import SwiftUI
import Combine


protocol LoginNavigationDelegate: AnyObject {
    func onSwitchToRegister()
    func onLoginActionSuccess()
}

extension LoginView {
    
    class ViewModel: ObservableObject {
        
        @Published var email: String = ""
        @Published var password: String = ""
        
        @Published var showAlert: Bool = false
        var alertTitle: String = ""
        var alertMessage: String = ""
        
        weak var navigationDelegate: LoginNavigationDelegate?
        
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
extension LoginView.ViewModel {
    
    func onLoginUserAction() {
        
        guard !email.isEmpty, !password.isEmpty else {
            alertTitle = "Oops!"
            alertMessage = "Please check the fields are not empty"
            showAlert = true
            return
        }
        
        let route = NetworkRoutes.login
        guard let url = route.url else {
            alertTitle = "Oops!"
            alertMessage = "Can't configure a login request"
            showAlert = true
            return
        }
        
        let json = ["email": email,
                    "password": password]
        
        Task {
            do {
                let responseData = try await networkHandler.reuest(url,
                                                                   params: json,
                                                                   responseType: AccessToken.self,
                                                                   method: route.method.rawValue)
                
                guard tokenStorage.save(responseData) else {
                    alertTitle = "Oops!"
                    alertMessage = "Can't save a token!"
                    showAlert = true
                    return
                }
                
                await MainActor.run { [weak self] in
                    self?.navigationDelegate?.onLoginActionSuccess()
                }
                
            } catch {
                await MainActor.run { [weak self] in
                    guard let `self` else { fatalError("Should never happen case! Please check for errors") }
                    self.alertTitle = "Error!"
                    self.alertMessage = error.localizedDescription
                    self.showAlert = true
                    return
                }
            }
            
        }
        
    }
    
    func loginActionSuccess() {
        navigationDelegate?.onLoginActionSuccess()

    }
    
    func loginActionFailure() {
        //TODO: - retry action ?
    }
    
    func onRegisterUserAction() {
        navigationDelegate?.onSwitchToRegister()
    }
    
}
