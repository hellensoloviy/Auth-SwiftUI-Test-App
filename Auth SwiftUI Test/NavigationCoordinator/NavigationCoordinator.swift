//
//  NavigationCoordinator.swift
//  Auth SwiftUI Test
//
//  Created by Hellen Soloviy on 20.01.2026.
//

import Foundation
import SwiftUI


//TODO: - Think on possibility of scaling this up as a solution for navigation of big app with a lot of pathes
enum ScreenPath: String, Identifiable {
    
    var id: String { return self.rawValue }
    
    case home
    case login
    case register
    
}

class NavigationCoordinator: ObservableObject {
    
    @Published var path = [ScreenPath]()
    
    var isLoggedIn: Bool { tokenStorage.get() != nil }
    
    //MARK: - Private
    private let tokenStorage = AccessTokenStorage()
    private let networkHandler = NetworkHandler()
    
    //MARK: -
    func logout() {
        guard tokenStorage.delete() else {
            fatalError("⚫ [NavigationCoordinator] Can't delete token. Please check the code for the token storage.")
        }
        
        path = [] /// goes to default
    }
    
    //MARK: - ViewBuilder
    @ViewBuilder
    func rootView() -> some View {
        if isLoggedIn {
            configureViewHome()
        } else {
            configureViewLogin()
        }
    }
    
    @ViewBuilder
    func screenForPath(_ screenPath: ScreenPath) -> some View {
        switch screenPath {
        case .home: configureViewHome()
        case .login: configureViewLogin()
        case .register: configureViewRegister()
        }
 
    }
    
}

//MARK: - Navigation Logic
extension NavigationCoordinator {
    
    var currentPage: ScreenPath? {
        path.last
    }
    
    var previousPage: ScreenPath? {
        guard path.count > 1 else { return nil }
        return path[path.count - 2]
    }
    
    func push(_ page: ScreenPath) {
        path.append(page)
    }
    
    func pop() {
        path.removeLast()
    }
    
}


//MARK: - Configuration Views
//MARK: Home Screen
private extension NavigationCoordinator {
    
    
    func makeViewModelHome() -> HomeView.ViewModel {
        let viewModel = HomeView.ViewModel()
        viewModel.navigationDelegate = self
        return viewModel
    }
    
    @ViewBuilder
    func configureViewHome() -> some View {
        HomeView(viewModel: self.makeViewModelHome())
    }
    
}

extension NavigationCoordinator: HomeViewNavigationDelegate {
    
    func onLogout() {
        logout()
    }
    
}

//MARK: Register Screen

private extension NavigationCoordinator {
    
    
    func makeViewModelRegister() -> RegisterView.ViewModel {
        let viewModel = RegisterView.ViewModel()
        viewModel.navigationDelegate = self
        return viewModel
    }
    
    @ViewBuilder
    func configureViewRegister() -> some View {
        RegisterView(viewModel: self.makeViewModelRegister())
    }
    
}

extension NavigationCoordinator: RegisterNavigationDelegate {
    func onRegisterActionStart() {
        path = [] /// default view to show
    }
    
    func onSwitchToLogin() {
        /// Here we should just make path a default value, because if user is not logged in we already have a default view == login.
        /// If we add a [.login] here we will create an additional login screen in the hierarchy.
        path = []
    }
    

}

//MARK: Login Screen
private extension NavigationCoordinator {
    
    
    func makeViewModelLogin() -> LoginView.ViewModel {
        let viewModel = LoginView.ViewModel()
        viewModel.navigationDelegate = self
        return viewModel
    }
    
    @ViewBuilder
    func configureViewLogin() -> some View {
        LoginView(viewModel: self.makeViewModelLogin())
    }
    
}

extension NavigationCoordinator: LoginNavigationDelegate {
    func onLoginActionStart() {
        path = []
    }
    
    func onSwitchToRegister() {
        path = [.register] //TODO: - check this vs path.append(.register)
    }

}
