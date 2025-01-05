//
//  Auth0Service.swift
//  MADiOS
//
//  Created by Bram Rampelberg on 03/01/2025.
//  Copyright © 2025 HOGENT. All rights reserved.
//

import Foundation
import Auth0

final class Auth0Service {
    static let shared = Auth0Service()
    
    private let client = Auth0Manager.shared.client
    
    func login(email: String, password: String) async throws -> Credentials {
        let request = client.loginDefaultDirectory(
            withUsername: email,
            password: password,
            audience: Auth0Manager.shared.audience,
            scope: "openid profile email roles"
        )
        return try await request.start()
    }
    
    private init() { }
}
