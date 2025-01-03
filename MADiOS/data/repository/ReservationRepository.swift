//
//  ReservationRepository.swift
//  MADiOS
//
//  Created by Bram Rampelberg on 02/01/2025.
//  Copyright © 2025 HOGENT. All rights reserved.
//

import Foundation
import CoreData

class ReservationRepository {
    private let context = CoreDataStack.shared.persistentContainer.viewContext
    private let sharedCoreDataStack = CoreDataStack.shared
    
    init() {
        
    }
    
    func getReservations () -> [ReservationEntity] {
        let request = NSFetchRequest<ReservationEntity>(entityName: "ReservationEntity")
        
        do {
            return try context.fetch(request)
        }catch {
            print("DEBUG: Some error occured while fetching")
        }
        return []
    }
    
    func addReservation (_ reservation: Reservation){
        let reservationEntity = ReservationEntity(context: context)
        reservationEntity.id = Int32(reservation.id)
        reservationEntity.isRemoved = reservation.isDeleted
        reservationEntity.boatId = Int32(reservation.boatId)
        reservationEntity.boatPersonalName = reservation.boatPersonalName
        reservationEntity.date = reservation.date
        reservationEntity.start = reservation.start
        reservationEntity.end = reservation.end
        
        sharedCoreDataStack.save()
    }
}
