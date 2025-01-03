//
//  ReservationsModel.swift
//  MADiOS
//
//  Created by Bram Rampelberg on 02/01/2025.
//  Copyright © 2025 HOGENT. All rights reserved.
//

import Foundation

struct ReservationsModel {
    private(set) var reservations: [Reservation]
    private(set) var selectedReservation: Reservation?
    private(set) var selectedReservationType: ReservationType
    private(set) var selectedReservationDetails: ReservationDetails?
    
    mutating func setReservations(to reservations: [Reservation]){
        self.reservations = reservations
    }
    
    mutating func setReservationDetails(to reservationDetails: ReservationDetails?){
        selectedReservationDetails = reservationDetails
    }
    
    mutating func changeSelectedReservation(to reservation: Reservation?){
        selectedReservation = reservation
    }
    
    mutating func changeSelectedReservationType(to type: ReservationType){
        selectedReservationType = type
    }
    
    enum ReservationType {
        case upcoming
        case old
        case canceled
    }
}
