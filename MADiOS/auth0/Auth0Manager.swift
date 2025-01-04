//
//  Auth0Manager.swift
//  MADiOS
//
//  Created by Bram Rampelberg on 03/01/2025.
//  Copyright © 2025 HOGENT. All rights reserved.
//

import Foundation
import Auth0

class Auth0Manager {
    static let manager = Auth0Manager()
    
    lazy var client: Auth0.Authentication = {
        guard let path = Bundle.main.path(forResource: "Auth0", ofType: "plist"),
              let auth0Dict = NSDictionary(contentsOfFile: path) as? [String: Any],
              let clientId = auth0Dict["ClientId"] as? String,
              let domain = auth0Dict["Domain"] as? String else {
            fatalError("Auth0.plist file is missing or invalid")
        }
        return Auth0.authentication(clientId: clientId, domain: domain)
    }()
    
    lazy var credentialsManager: CredentialsManager = {
        CredentialsManager(authentication: client)
    }()
}
