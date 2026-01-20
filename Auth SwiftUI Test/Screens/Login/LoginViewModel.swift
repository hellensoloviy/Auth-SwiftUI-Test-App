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
    func onLoginActionStart()
}

extension LoginView {
    
    class ViewModel: ObservableObject {
        
        @Published var email: String = ""
        @Published var password: String = ""
        
        weak var navigationDelegate: LoginNavigationDelegate?
    }
    
}

//MARK: - Actions
extension LoginView.ViewModel {
    
    func onLoginUserAction() {
        navigationDelegate?.onLoginActionStart()
    }
    
    func onRegisterUserAction() {
        navigationDelegate?.onSwitchToRegister()
    }
    
}
