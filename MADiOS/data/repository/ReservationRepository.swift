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
    
    func getReservations (isPast: Bool, isCanceled: Bool) -> [ReservationEntity] {
        let calendar = Calendar(identifier: .gregorian)
        let startOfDay = calendar.startOfDay(for: Date()) as NSDate
        
        let request = NSFetchRequest<ReservationEntity>(entityName: "ReservationEntity")
        let isCanceledPredicate = NSPredicate(format: "isRemoved = %@", isCanceled as NSNumber)
        
        if !isCanceled {
            if isPast {
                request.predicate = NSCompoundPredicate(type: .and, subpredicates: [isCanceledPredicate, NSPredicate(format: "date < %@", startOfDay)])
            }
            else {
                request.predicate = NSCompoundPredicate(type: .and, subpredicates: [isCanceledPredicate, NSPredicate(format: "date >= %@", startOfDay)])
            }
        }
        else {
            request.predicate = isCanceledPredicate
        }
        
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
