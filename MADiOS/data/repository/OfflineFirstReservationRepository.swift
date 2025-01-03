//
//  OfflineFirstReservationRepository.swift
//  MADiOS
//
//  Created by Bram Rampelberg on 02/01/2025.
//  Copyright © 2025 HOGENT. All rights reserved.
//

import Foundation

class OfflineFirstReservationRepository {
    
    private let reservationRepo = ReservationRepository()
    
    func getReservations(isPast: Bool, isCanceled: Bool) -> [Reservation] {
        reservationRepo.getReservations(isPast: isPast, isCanceled: isCanceled).map { enitity in
            Reservation(fromEntity: enitity)
        }
    }
    
    func addReservation(_ reservation: Reservation) {
        reservationRepo.addReservation(reservation)
    }
    
    func getReservationDetails(for reservation: Reservation) -> ReservationDetails {
        ReservationDetails(mentorName: "mentor", batteryId: 1, currentBatteryUserName: "username", currentBatteryUserId: 1, currentHolderPhoneNumber: "phonenumber", currentHolderEmail: "email", currentHolderStreet: "street", currentHolderNumber: "number", currentHolderCity: "city", currentHolderPostalCode: "postalCode")
    }
}
