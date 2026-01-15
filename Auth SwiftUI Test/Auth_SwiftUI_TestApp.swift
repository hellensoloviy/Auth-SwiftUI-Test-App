//
//  Auth_SwiftUI_TestApp.swift
//  Auth SwiftUI Test
//
//  Created by Hellen Soloviy on 15.01.2026.
//

import SwiftUI

/// Added just to have a check on all the previews 
#Preview {
    LoginView()
}

@main
struct Auth_SwiftUI_TestApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
