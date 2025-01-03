//
//  ReservationTypePicker.swift
//  MADiOS
//
//  Created by Bram Rampelberg on 02/01/2025.
//  Copyright © 2025 HOGENT. All rights reserved.
//

import SwiftUI

struct ReservationTypePicker: View {
    @EnvironmentObject var reservationsViewModel: ReservationsViewModel
    
    var body: some View {
        HStack {
            Text("Type:")
                .font(.headline)
            Picker("Type", selection: $reservationsViewModel.selectedReservationType) {
                Text("Upcoming").tag(ReservationType.upcoming)
                Text("Old").tag(ReservationType.old)
                Text("Canceled").tag(ReservationType.canceled)
            }
            Spacer()
        }.padding(.horizontal, 20)
    }
}

#Preview {
    ReservationTypePicker()
}
