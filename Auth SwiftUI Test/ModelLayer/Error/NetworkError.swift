//
//  NetworkError.swift
//  Auth SwiftUI Test
//
//  Created by Hellen Soloviy on 19.01.2026.
//

import Foundation

enum NetworkError: Error {
    
    case userError(String)
    case dataError(String)
    case encodingError
    case decodingError
    case failedStatusCode(String)
    case failedStatusCodeResponse(Int, Data)
    case noResponse
    
    var statusCodeResponseData: (Int, Data)? {
        if case let .failedStatusCodeResponse(statusCode, data) = self {
            return (statusCode, data)
        }
        
        return nil
        
    }
    
}
