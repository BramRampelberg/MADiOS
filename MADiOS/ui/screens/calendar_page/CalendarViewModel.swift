//
//  CalendarViewModel.swift
//  MADiOS
//
//  Created by Bram Rampelberg on 02/01/2025.
//  Copyright © 2025 HOGENT. All rights reserved.
//

import Foundation

class CalendarViewModel: ObservableObject {
    private let reservationRepo = OfflineFirstReservationRepository()
    
    init() {
        self.reservations = reservationRepo.getReservations()
    }
    
    @Published private var reservations: [Reservation]
}
