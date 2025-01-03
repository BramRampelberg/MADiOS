//
//  ReservationsPage.swift
//  MADiOS
//
//  Created by Bram Rampelberg on 01/01/2025.
//  Copyright © 2025 HOGENT. All rights reserved.
//

import SwiftUI

struct ReservationsPage: View {
    @StateObject var reservationsViewModel = ReservationsViewModel()
    
    var body: some View {
            VStack {
                ReservationTypePicker()
                ReservationsList()
            }.environmentObject(reservationsViewModel)
            .sheet(isPresented: $reservationsViewModel.isReservationSelected) {
                ReservationDetail(reservation: reservationsViewModel.selectedReservation!, reservationDetails: reservationsViewModel.reservationDetails)
                    .presentationDetents([.medium, .large])
            }
    }
}

#Preview {
    @Previewable @StateObject var reservationsViewModel = ReservationsViewModel()
    
    ReservationsPage().environmentObject(reservationsViewModel)
}
//
