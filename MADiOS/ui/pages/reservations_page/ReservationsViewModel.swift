//
//  ReservationsViewModel.swift
//  MADiOS
//
//  Created by Bram Rampelberg on 02/01/2025.
//  Copyright © 2025 HOGENT. All rights reserved.
//

import Foundation
import SwiftUI


class ReservationsViewModel: ObservableObject {
    
    private let reservationRepo = OfflineFirstReservationRepository.shared
    
    @MainActor
    init() {
        // TODO: cleanup
        //let calendar = Calendar(identifier: .gregorian)
        //let yesterday = calendar.date(byAdding: .day, value: -1, to: Date())
        reservationsModel = ReservationsModel(reservations: [], selectedReservationType: ReservationType.upcoming)
        //        for index in 0...20 {
        //            addReservation(Reservation(start: Date(), end: Date(), date: index % 2 == 0 ? yesterday ?? Date() : Date(), boatId: 1, boatPersonalName: "boatName", id: index, isDeleted: index % 3 == 0))
        //        }
        getReservations()
    }
    
    @Published private var reservationsModel: ReservationsModel
    
    var reservations: [Reservation] {
        reservationsModel.reservations
    }
    
    @MainActor
    var selectedReservationType: ReservationType {
        get {
            reservationsModel.selectedReservationType
        }
        set {
            reservationsModel.changeSelectedReservationType(to: newValue)
            getReservations()
        }
    }
    
    var reservationDetailsState: ReservationDetailsState {
        reservationsModel.reservationDetailsState
    }
    
    @MainActor
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
                reservationsModel.changeReservationDetailsState(to: .unselected)
            }
        }
    }
    
    @MainActor
    func setReservationDetails(for reservation: Reservation?){
        if reservation == nil {
            reservationsModel.changeReservationDetailsState(to: .unselected)
        } else {
            reservationsModel.changeReservationDetailsState(to: .loading)
            Task {
                //TODO: show some kind of error to user when failure
                let result = await reservationRepo.getReservationDetails(for: reservation!)
                if result.isSuccess {
                    reservationsModel.changeReservationDetailsState(to: .selected(result.data!))
                } else {
                    reservationsModel.changeReservationDetailsState(to: .error(result.failureCause!))
                }
            }
        }
    }
    
    @MainActor
    func addReservation(_ reservation: Reservation) {
        //TODO: cleanup
        reservationRepo.addReservation(reservation)
        getReservations()
    }
    
    @MainActor
    private func getReservations() {
        let type = reservationsModel.selectedReservationType
        let isPast = type == .past
        let isCanceled = type == .canceled
        reservationsModel.setReservations(to: reservationRepo.getOfflineReservations(isPast: isPast, isCanceled: isCanceled))
        Task{
            //TODO: use result
            _ = await reservationRepo.loadOnlineReservations(isPast: isPast, isCanceled: isCanceled)
            reservationsModel.setReservations(to: reservationRepo.getOfflineReservations(isPast: isPast, isCanceled: isCanceled))
        }
    }
}
