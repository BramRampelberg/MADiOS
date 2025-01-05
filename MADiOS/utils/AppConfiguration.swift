//
//  AppConfiguration.swift
//  MADiOS
//
//  Created by Bram Rampelberg on 04/01/2025.
//  Copyright © 2025 HOGENT. All rights reserved.
//

import Foundation

final class AppConfiguration {
    static let shared = AppConfiguration()
    
    let baseUrl: URL

    private init() {
        guard let infoDict = Bundle.main.infoDictionary else {
            fatalError("Missing Info.plist file.")
        }

        if let baseUrl = infoDict["BASE_URL"] as? String,
           let url = URL(string: baseUrl) {
            self.baseUrl = url
        } else {
            fatalError("BASE_URL is missing or invalid in Info.plist.")
        }
        
        AppLogger.info("App config initialized.")
    }
}
