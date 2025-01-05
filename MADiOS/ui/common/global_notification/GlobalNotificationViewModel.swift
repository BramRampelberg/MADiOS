//
//  GlobalNotificationViewModel.swift
//  MADiOS
//
//  Created by Bram Rampelberg on 05/01/2025.
//  Copyright © 2025 HOGENT. All rights reserved.
//

import Foundation

class GlobalNotificationViewModel: ObservableObject {
    @Published private var globalNotificationModel: GlobalNotificationModel
    
    init() {
        self.globalNotificationModel = GlobalNotificationModel()
    }
    
    var notification: String? {
        globalNotificationModel.message
    }
    
    var hasNotification: Bool {
        globalNotificationModel.message != nil
    }
    
    func setGlobalNotification(to message: String){
        globalNotificationModel.setMessage(to: message)
    }
    
    func clearGlobalNotification(){
        globalNotificationModel.setMessage(to: nil)
    }
}
