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
        VStack(spacing: 0) {
            ReservationTypePicker()
            ReservationsList()
        }.environmentObject(reservationsViewModel)
            .sheet(isPresented: $reservationsViewModel.isReservationSelected) {
                if reservationsViewModel.reservationDetailsState.isLoading {
                    ProgressView().presentationDetents([.medium, .large])
                } else if reservationsViewModel.reservationDetailsState.hasError {
                    Text(reservationsViewModel.reservationDetailsState.errorDescription!).font(.title2).foregroundColor(.red).presentationDetents([.medium, .large])
                } else {
                    ReservationDetail(reservation: reservationsViewModel.selectedReservation!, reservationDetails: reservationsViewModel.reservationDetailsState.reservationDetails)
                        .presentationDetents([.medium, .large])
                }
            }
    }
}

#Preview {
    @Previewable @StateObject var reservationsViewModel = ReservationsViewModel()
    
    ReservationsPage().environmentObject(reservationsViewModel)
}
//
