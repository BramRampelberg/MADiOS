//
//  Auth0Service.swift
//  MADiOS
//
//  Created by Bram Rampelberg on 03/01/2025.
//  Copyright © 2025 HOGENT. All rights reserved.
//

import Foundation
import Auth0

class Auth0Service {
    private let client = Auth0Manager.manager.client
    
    func login(email: String, password: String) async throws -> Credentials {
        let request = client.loginDefaultDirectory(
            withUsername: email,
            password: password,
            audience: "https://api.buut.be",
            scope: "openid profile email roles"
        )
        return try await request.start()
    }
}
