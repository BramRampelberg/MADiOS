//
//  ReservationsViewModel.swift
//  MADiOS
//
//  Created by Bram Rampelberg on 02/01/2025.
//  Copyright © 2025 HOGENT. All rights reserved.
//

import Foundation


class ReservationsViewModel: ObservableObject {
    
    private let reservationRepo = OfflineFirstReservationRepository()
    
    init() {
        // TODO: cleanup
        let calendar = Calendar(identifier: .gregorian)
        let yesterday = calendar.date(byAdding: .day, value: -1, to: Date())
        self.reservationsModel = ReservationsModel(reservations: [], selectedReservationType: ReservationType.upcoming)
        for index in 0...20 {
            addReservation(Reservation(start: Date(), end: Date(), date: index % 2 == 0 ? yesterday ?? Date() : Date(), boatId: 1, boatPersonalName: "boatName", id: index, isDeleted: index % 3 == 0))
        }
        self.reservationsModel.setReservations(to: getReservations())
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
            reservationsModel.setReservations(to: getReservations())
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
        reservationsModel.setReservations(to: getReservations())
    }
    
    func getReservations() -> [Reservation] {
        let type = reservationsModel.selectedReservationType
        return reservationRepo.getReservations(isPast: type == ReservationType.old, isCanceled: type == ReservationType.canceled)
    }
}
