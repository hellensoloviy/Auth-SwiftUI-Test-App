//
//  NetworkRoutes.swift
//  Auth SwiftUI Test
//
//  Created by Hellen Soloviy on 20.01.2026.
//

import Foundation

enum NetworkRoutes {
    
    private static let baseURL = "http://127.0.0.1:8000/"
    
    case login
    case register
    case accessToken
    
    var url: URL? {
        var path: String
        switch self {
        case .login: path = NetworkRoutes.baseURL + "api/login_data/"
        case .register: path = NetworkRoutes.baseURL + "api/register/"
        case .accessToken: path = NetworkRoutes.baseURL + "api/auth/token/"
        }
        
        
        guard let urlToReturn = URL(string: path) else {
            print("📕 [NetworkRoutes] Can't create URL")
            return nil
        }
        return urlToReturn
    }
    
    var method: HTTPMethod {
        switch self {
        case .login, .register: return .post
        case .accessToken: return .get
            
        }
    }
    
}
