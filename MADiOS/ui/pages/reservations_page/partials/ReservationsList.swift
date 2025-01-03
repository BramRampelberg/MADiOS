//
//  ReservationsList.swift
//  MADiOS
//
//  Created by Bram Rampelberg on 02/01/2025.
//  Copyright © 2025 HOGENT. All rights reserved.
//

import SwiftUI

struct ReservationsList: View {
    @EnvironmentObject var reservationsViewModel: ReservationsViewModel
    
    var body: some View {
        List(reservationsViewModel.reservations) { reservation in
            Button(action: {
                reservationsViewModel.selectedReservation = reservation
            }) {
                ImportantReservationInfo(date: reservation.date, start: reservation.start, end: reservation.end, boatPersonalName: reservation.boatPersonalName)
            }.foregroundColor(.primary)
        }
    }
}

#Preview {
    ReservationsList()
}
