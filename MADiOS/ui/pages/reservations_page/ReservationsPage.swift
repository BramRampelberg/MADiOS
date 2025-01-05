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
    
    private var reservationDetailsState: ReservationDetailsState {
        reservationsViewModel.reservationDetailsState
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ReservationTypePicker()
            ReservationsList()
        }
            .sheet(isPresented: $reservationsViewModel.isReservationSelected) {
                if reservationDetailsState.isLoading {
                    ProgressView().presentationDetents([.medium, .large])
                } else if reservationDetailsState.hasError {
                    Text(reservationDetailsState.errorDescription!).font(.title2).foregroundColor(Colors.red).presentationDetents([.medium, .large])
                } else {
                    ScrollView {
                        ReservationDetail(reservation: reservationsViewModel.selectedReservation!, reservationDetails: reservationDetailsState.reservationDetails, isReservationCancelable: reservationsViewModel.isReservationCancelable)
                            .presentationContentInteraction(.scrolls)
                    }.padding(.bottom, 16)
                }
            }.environmentObject(reservationsViewModel)
    }
}

#Preview {
    @Previewable @StateObject var reservationsViewModel = ReservationsViewModel()
    
    ReservationsPage().environmentObject(reservationsViewModel)
}
//
