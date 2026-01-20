//
//  NavigationCoordinatorView.swift
//  Auth SwiftUI Test
//
//  Created by Hellen Soloviy on 20.01.2026.
//

import SwiftUI

struct NavigationCoordinatorView: View {
    
    @StateObject var coordinator: NavigationCoordinator = .init()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            /// The cons of pattern used in the app is that we need to manage this root view here, additonally.
            /// Maybe think of another solution in the future updates of the app
            coordinator.rootView()
                .navigationBarTitleDisplayMode(.inline)
                .navigationDestination(for: ScreenPath.self) { path in
                    coordinator.screenForPath(path)
                }
        }
    }
}

#Preview {
    NavigationCoordinatorView()
}
