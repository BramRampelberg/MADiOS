//
//  Auth0Manager.swift
//  MADiOS
//
//  Created by Bram Rampelberg on 03/01/2025.
//  Copyright © 2025 HOGENT. All rights reserved.
//

import Foundation
import Auth0

final class Auth0Manager {
    static let shared = Auth0Manager()
    
    let clientId: String
    let domain: String
    let audience: String
    
    lazy var client: Auth0.Authentication = {
        return Auth0.authentication(clientId: clientId, domain: domain)
    }()
    
    lazy var credentialsManager: CredentialsManager = {
        CredentialsManager(authentication: client)
    }()
    
    private init () {
        guard let path = Bundle.main.path(forResource: "Auth0", ofType: "plist"),
              let auth0Dict = NSDictionary(contentsOfFile: path) as? [String: Any],
              let clientId = auth0Dict["ClientId"] as? String,
              let domain = auth0Dict["Domain"] as? String,
        let audience = auth0Dict["Audience"] as? String else {
            fatalError("Auth0.plist file is missing or invalid")
        }
        self.clientId = clientId
        self.domain = domain
        self.audience = audience
    }
}
