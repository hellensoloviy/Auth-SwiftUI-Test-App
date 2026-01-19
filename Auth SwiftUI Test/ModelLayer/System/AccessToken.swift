//
//  AccessToken.swift
//  Auth SwiftUI Test
//
//  Created by Hellen Soloviy on 19.01.2026.
//

import Foundation

struct AccessToken: Codable {
    var accessToken: String
    var refreshToken: String
    
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "token"
        case refreshToken = "refresh"
    }
}
