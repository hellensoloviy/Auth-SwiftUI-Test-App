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
        
    }
    
}

//MARK: - Actions
extension HomeView.ViewModel {
    
    func onLogoutUserAction() {
        navigationDelegate?.onLogout()
    }
    
    func onResetInfoText() {
        infoText = ""
    }
    
    func onFetchAction() {
        //TODO: not implemented at the moment
        
        infoText = "Secure data will be here"
    }
    
}
