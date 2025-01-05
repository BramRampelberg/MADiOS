//
//  GlobalNotificationModel.swift
//  MADiOS
//
//  Created by Bram Rampelberg on 05/01/2025.
//  Copyright © 2025 HOGENT. All rights reserved.
//

import Foundation

struct GlobalNotificationModel {
    private(set) var message: String?
    
    mutating func setMessage(to message: String?){
        self.message = message
    }
}
