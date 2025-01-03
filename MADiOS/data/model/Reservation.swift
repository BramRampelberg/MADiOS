//
//  ReservationModel.swift
//  MADiOS
//
//  Created by Bram Rampelberg on 02/01/2025.
//  Copyright © 2025 HOGENT. All rights reserved.
//

import Foundation
import CoreData

struct Reservation: Identifiable, Hashable {
    var start: Date
    var end: Date
    var date: Date
    var boatId: Int
    var boatPersonalName: String
    var id: Int
    var isDeleted: Bool
    
    init(start: Date, end: Date, date: Date, boatId: Int, boatPersonalName: String, id: Int, isDeleted: Bool) {
        self.start = start
        self.end = end
        self.date = date
        self.boatId = boatId
        self.boatPersonalName = boatPersonalName
        self.id = id
        self.isDeleted = isDeleted
    }
    
    init(fromEntity entity: ReservationEntity) {
        start = entity.start!
        end = entity.end!
        date = entity.date!
        boatId = Int(entity.boatId)
        boatPersonalName = entity.boatPersonalName!
        id = Int(entity.id)
        isDeleted = entity.isRemoved
    }
}
