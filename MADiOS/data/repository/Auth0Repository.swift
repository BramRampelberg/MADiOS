//
//  Auth0Repository.swift
//  MADiOS
//
//  Created by Bram Rampelberg on 03/01/2025.
//  Copyright © 2025 HOGENT. All rights reserved.
//

import Foundation
import Auth0

final class Auth0Repository {
    static let shared = Auth0Repository()
    
    private let credentialsManager = Auth0Manager.shared.credentialsManager
    private let auth0Service = Auth0Service.shared
    
    func login(email: String, password: String) async -> Result<Void> {
        do {
            let credentials = try await auth0Service.login(email: email, password: password)
            return credentialsManager.store(credentials: credentials) ? Result.success(data: Void()) : .failureWithLog(cause: "Failed to store credentials")
        }
        catch let error as Auth0APIError {
            return .failureWithLog(cause: error.cause?.localizedDescription ?? error.localizedDescription, error: error)
        }
        catch {
            return .failureWithLog(cause: error.localizedDescription, error: error)
        }
    }
    
    func logout() -> Bool {
        let success = credentialsManager.clear()
        if success {
            return success
        }
        return false
    }
    
    func getCredentials() async throws -> Credentials {
        return try await credentialsManager.credentials()
    }
    
    func userIsLoggedIn() -> Bool {
        credentialsManager.hasValid()
    }
    
    private init() { }
}
