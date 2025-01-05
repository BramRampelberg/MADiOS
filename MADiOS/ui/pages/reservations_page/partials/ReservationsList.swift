//
//  ReservationsList.swift
//  MADiOS
//
//  Created by Bram Rampelberg on 02/01/2025.
//  Copyright © 2025 HOGENT. All rights reserved.
//

import SwiftUI

struct ReservationsList: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @EnvironmentObject var reservationsViewModel: ReservationsViewModel
    @State private var selected: Int? = nil
    
    var body: some View {
        if horizontalSizeClass == .compact {
            List(reservationsViewModel.reservations) { reservation in
                Button(action: {
                    reservationsViewModel.selectedReservation = reservation
                }) {
                    ImportantReservationInfo(date: reservation.date, start: reservation.start, end: reservation.end, boatPersonalName: reservation.boatPersonalName)
                }.foregroundColor(.primary)
            }
        } else {
            Table(reservationsViewModel.reservations, selection: $selected) {
                TableColumn("Date") { reservation in
                    Text("Date: \(reservation.date.formatted(.dateTime.day().month().year()))")
                }
                TableColumn("Time"){ reservation in
                    Text("\(reservation.start.formatted(.dateTime.hour().minute())) - \(reservation.end.formatted(.dateTime.hour().minute()))")
                }
                TableColumn("Boat"){ reservation in
                    Text("Boat: \(reservation.boatPersonalName)")
                }
            }.onChange(of: selected) { oldId, newId in
                let reservation = reservationsViewModel.reservations.first { reservation in
                    reservation.identifier == newId
                }
                reservationsViewModel.selectedReservation = reservation
            }
        }
    }
}

#Preview {
    ReservationsList()
}
