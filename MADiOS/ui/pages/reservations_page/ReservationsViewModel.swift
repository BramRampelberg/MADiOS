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
    
    @Published private var cancelReservationState: CancelReservationState = .resting
    
    var hasCancelError: Bool {
        cancelReservationState.hasError
    }
    
    var cancelErrorDescription: String? {
        cancelReservationState.errorDescription
    }
    
    var isCancelationPending: Bool {
        cancelReservationState.isLoading
    }
    
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
            if newValue == nil {
                deselectReservation()
            }
            else {
                reservationsModel.changeSelectedReservation(to: newValue)
                changeReservationDetailsSate(for: newValue)
            }
        }
    }
    
    var isReservationCancelable: Bool {
        if let currentDatePlusTwoDays = Calendar.current.date(byAdding: .day, value: 2, to: Date()) {
            return reservationsModel.selectedReservation != nil
            && reservationsModel.selectedReservation!.date > currentDatePlusTwoDays
            && (cancelReservationState.isResting || cancelReservationState.hasError)
        }
        return false
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
    func changeReservationDetailsSate(for reservation: Reservation?){
        if reservation == nil {
            reservationsModel.changeReservationDetailsState(to: .unselected)
        } else {
            reservationsModel.changeReservationDetailsState(to: .loading)
            Task {
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
    func cancelReservation() {
        if isReservationCancelable {
            //TODO: show error on failure
            cancelReservationState = .loading
            Task {
                let result = await reservationRepo.cancelReservation(reservationsModel.selectedReservation!)
                if result.isSuccess {
                    cancelReservationState = .resting
                    deselectReservation()
                    getReservations()
                } else {
                    cancelReservationState = .error(result.failureCause!)
                }
            }
        }
    }
    
    //    @MainActor
    //    func addReservation(_ reservation: Reservation) {
    //        //TODO: cleanup
    //        reservationRepo.addReservation(reservation)
    //        getReservations()
    //    }
    
    @MainActor
    private func deselectReservation(){
        reservationsModel.changeSelectedReservation(to: nil)
        changeReservationDetailsSate(for: nil)
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
    
    enum CancelReservationState {
        case resting
        case loading
        case error(String)
        
        var isResting: Bool {
            switch self {
            case .resting: return true
            default: return false
            }
        }
        
        var isLoading: Bool {
            switch self {
            case .loading: return true
            default: return false
            }
        }
        
        var hasError: Bool {
            switch self {
            case .error: return true
            default: return false
            }
        }
        
        var errorDescription: String? {
            switch self {
            case .error(let description): return description
            default: return nil
            }
        }
    }
    
}
