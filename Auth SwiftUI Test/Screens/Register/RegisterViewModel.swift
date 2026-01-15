//
//  RegisterViewModel.swift
//  Auth SwiftUI Test
//
//  Created by Olena Solovii AFT on 15.01.2026.
//

import Combine
import SwiftUI

protocol RegisterNavigationDelegate: AnyObject {
    func onRegister()
    func onSwitchToLogin()
}

extension RegisterView {
    
    class ViewModel: ObservableObject {
        
        @Published var email: String = ""
        @Published var password: String = ""
        @Published var confirmPassword: String = ""
        
        weak var navigationDelegate: RegisterNavigationDelegate?

    }
    
}

//MARK: - Action
extension RegisterView.ViewModel {
    
    func onLoginUserAction() {
        navigationDelegate?.onSwitchToLogin()
    }
    
    func onRegisterUserAction() {
        navigationDelegate?.onRegister()
    }
    
}
