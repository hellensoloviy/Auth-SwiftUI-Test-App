//
//  AccessTokenStorage.swift
//  Auth SwiftUI Test
//
//  Created by Hellen Soloviy on 19.01.2026.
//

import Foundation
import Security

/// Need to be aware of risks that the data is not deleted when the app is deleted
struct AccessTokenStorage {
    
    private let accountKey = "com.hellen.soloviy.auth_swiftui_app_access_token" //TODO: - another way to define by using app build settings ?
    
    func save(_ token: AccessToken) -> Bool {
        
        //TODO: - check is deleted succesfully ? 
        delete()
        
        /// no handling throw at the moment
        guard let data = try? JSONEncoder().encode(token) else {
            return false
        }
        
        let saveQuery: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                    kSecAttrAccount: accountKey,
                                      kSecValueData: data]
        
        let status = SecItemAdd(saveQuery as CFDictionary, nil)
        return status == errSecSuccess
        
    }
    
    func get() -> AccessToken? {
        
        let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                    kSecAttrAccount: accountKey,
                                     kSecReturnData: true,
                                     kSecMatchLimit: kSecMatchLimitOne]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
       
        guard status == errSecSuccess,
              let data = item as? Data else {
            return nil
        }
        /// no handling throw at the moment
        return try? JSONDecoder().decode(AccessToken.self, from: data)
        
    }
    
    @discardableResult
    func delete() -> Bool {
        //TODO: - deepen an understanding of queries
        let deleteQuery: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                      kSecAttrAccount: accountKey]
        let status = SecItemDelete(deleteQuery as CFDictionary)
        return status == errSecSuccess
    }
    
}
