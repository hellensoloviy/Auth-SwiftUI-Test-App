//
//  RegisterViewModel.swift
//  Auth SwiftUI Test
//
//  Created by Hellen Soloviy on 15.01.2026.
//

import Combine
import SwiftUI

protocol RegisterNavigationDelegate: AnyObject {
    func onRegisterActionSuccess()
    func onSwitchToLogin()
}

extension RegisterView {
    
    class ViewModel: ObservableObject {
        
        @Published var email: String = ""
        @Published var password: String = ""
        @Published var confirmPassword: String = ""
        
        weak var navigationDelegate: RegisterNavigationDelegate?
        
        @Published var showAlert: Bool = false
        var alertTitle: String = ""
        var alertMessage: String = ""
        
        var isRegistrationSuccessfull = false
        
        //MARK: - Private
        
        private let networkHandler: NetworkHandler
        
        //MARK: -
        
        init(networkHandler: NetworkHandler) {
            self.networkHandler = networkHandler
        }
        

    }
    
}

//MARK: - Action
extension RegisterView.ViewModel {
    
    func onLoginUserAction() {
        navigationDelegate?.onSwitchToLogin()
    }
    
    func handleRegistrationResult() {
        if isRegistrationSuccessfull {
            registerActionSuccess()
        } else {
            /// nothing for now
        }
    }
    
    func registerActionSuccess() {
        navigationDelegate?.onRegisterActionSuccess()

    }
    
    func onRegisterUserAction() {

        guard !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            alertTitle = "Oops!"
            alertMessage = "Please check the fields are not empty"
            showAlert = true
            return
        }
        
        guard password == confirmPassword else {
            alertTitle = "Oops!"
            alertMessage = "The passwords should be equal"
            showAlert = true
            return
        }
        
        let route = NetworkRoutes.register
        guard let url = route.url else {
            alertTitle = "Oops!"
            alertMessage = "Can't configure a register request"
            showAlert = true
            return
        }
        
        let json = ["email": email,
                    "password": password,
                    "password2": confirmPassword]
        
        Task {
            do {
                _ = try await networkHandler.request(url,
                                                     params: json,
                                                     method: route.method.rawValue)
 
                
                await MainActor.run { [weak self] in
                    self?.isRegistrationSuccessfull = true
                    self?.alertTitle = "Congratulations!"
                    self?.alertMessage = "An activation email has been sent to \(self?.email  ?? "No email")"
                    self?.showAlert = true
                }
                
            } catch {
                await MainActor.run { [weak self] in
                    guard let `self` else { fatalError("Should never happen case! Please check for errors") }
                    self.isRegistrationSuccessfull = false
                    self.alertTitle = "Error!"
                    self.alertMessage = error.localizedDescription
                    self.showAlert = true
                    return
                }
            }
            
        }
    }
    
}
