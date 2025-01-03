//
//  ReservationsViewModel.swift
//  MADiOS
//
//  Created by Bram Rampelberg on 02/01/2025.
//  Copyright © 2025 HOGENT. All rights reserved.
//

import Foundation


class ReservationsViewModel: ObservableObject, Observable {
    typealias ReservationType = ReservationsModel.ReservationType
    
    private let reservationRepo = OfflineFirstReservationRepository()
    
    init() {
        // TODO: cleanup
        self.reservationsModel = ReservationsModel(reservations: [], selectedReservationType: ReservationType.upcoming)
        for index in 0...10 {
            addReservation(Reservation(start: Date(), end: Date(), date: Date(), boatId: 1, boatPersonalName: "boatName", id: index, isDeleted: false))
        }
        self.reservationsModel.setReservations(to: reservationRepo.getReservations())
    }
    
    @Published private var reservationsModel: ReservationsModel
    
    var reservations: [Reservation] {
        reservationsModel.reservations
    }
    
    var selectedReservation: Reservation? {
        get {
            reservationsModel.selectedReservation
        }
        set {
            reservationsModel.changeSelectedReservation(to: newValue)
            setReservationDetails(for: newValue)
        }
    }
    
    var isReservationSelected: Bool {
        get {
            reservationsModel.selectedReservation != nil
        }
        set {
            if !newValue {
                reservationsModel.changeSelectedReservation(to: nil)
                setReservationDetails(for: nil)
            }
        }
    }
    
    var selectedReservationType: ReservationType {
        get {
            reservationsModel.selectedReservationType
        }
        set {
            reservationsModel.changeSelectedReservationType(to: newValue)
        }
    }
    
    var reservationDetails: ReservationDetails? {
        reservationsModel.selectedReservationDetails
    }
    
    func setReservationDetails(for reservation: Reservation?){
        reservationsModel.setReservationDetails(to: reservation != nil ? reservationRepo.getReservationDetails(for: reservation!) : nil)
    }
    
    func addReservation(_ reservation: Reservation) {
        //TODO: cleanup
        reservationRepo.addReservation(reservation)
        self.reservationsModel.setReservations(to: reservationRepo.getReservations())
    }
}
