//
//  NetworkHandler.swift
//  Auth SwiftUI Test
//
//  Created by Hellen Soloviy on 19.01.2026.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    
}

enum ContentType: String {
    case json = "application/json; charset=utf-8"
    
}

enum HTTPHeaderField: String {
    case accept = "Accept"
    case contentType = "Content-Type"
    case authorization = "Authorization"
}

class NetworkHandler {
    
    func request(
        _ url: URL,
        params bodyParameters: Any?,
        method: String = HTTPMethod.get.rawValue,
        contentType: String? = ContentType.json.rawValue,
        accessToken: String? = nil
    ) async throws -> Data {
        
        var urlRequest = makeURLRequest(url,
                                        method: method,
                                        contentType: contentType,
                                        accessToken: accessToken)
        
        if let bodyParameters, let body = try? JSONSerialization.data(withJSONObject: bodyParameters) {
            urlRequest.httpBody = body
        } else if bodyParameters != nil {
            print("📕 Could not Serialize json body")
            throw ConfigurationError.nilObject
        }
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let httpResponse = response as? HTTPURLResponse else {
            print("📕 Could not get HTTPURLResponse for \(urlRequest.url?.absoluteString ?? "no URL")")
            throw NetworkError.noResponse
        }
            
        let statusCode = httpResponse.statusCode
        guard 200...299 ~= statusCode else {
            print("📕 Status code is NOT success for \(urlRequest.url?.absoluteString ?? "no URL")")
            throw NetworkError.failedStatusCodeResponse(statusCode, data)
        }
        
        return data
    }
    
    
    /// Add *responseType: ResponseType.Type* as a parameter inside adds more readability.
    /// Also, we can not do that and just define a generic ResponseType when using a request directly. Compiler will handle it.
    /// But that approach may be not so readable, so we add it as a parameter.
    func reuest<ResponseType: Decodable>(
        _ url: URL,
        params bodyParameters: Any?,
        responseType: ResponseType.Type,
        method: String = HTTPMethod.get.rawValue,
        contentType: String? = ContentType.json.rawValue,
        accessToken: String? = nil
    ) async throws -> ResponseType {
        let data = try await request(url,
                           params: bodyParameters,
                           method: method,
                           contentType: contentType,
                           accessToken: accessToken)
        
        return try JSONDecoder().decode(responseType, from: data)
    }
    
}

//MARK: - Make Request
extension NetworkHandler {
    
    func makeURLRequest(
        _ url: URL,
        method: String = HTTPMethod.get.rawValue,
        contentType: String? = ContentType.json.rawValue,
        accessToken: String? = nil
    ) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        
        if let contentType {
            request.addValue(contentType, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            if contentType.range(of: "json") != nil {
                request.addValue(contentType, forHTTPHeaderField: HTTPHeaderField.accept.rawValue)
            }
        }
        
        if let accessToken {
            let authKey = "Bearer \(accessToken)"
            request.addValue(authKey, forHTTPHeaderField: HTTPHeaderField.authorization.rawValue)
        }
        
        return request
        
    }
    
}
