//
//  ReservationDetail.swift
//  MADiOS
//
//  Created by Bram Rampelberg on 02/01/2025.
//  Copyright © 2025 HOGENT. All rights reserved.
//

import SwiftUI

struct ReservationDetail: View {
    let reservation: Reservation
    let reservationDetails: ReservationDetails?
    
    let padding: CGFloat = 16
    let groupSpacing: CGFloat = 8
    let groupTitleColor: Color = Colors.primary
    let groupTitleFont: Font = .title2
    
    var body: some View {
        HStack {
            VStack(alignment: .leading){
                Text("Reservation details").font(.title)
                ImportantReservationInfo(date: reservation.date, start: reservation.start, end: reservation.end, boatPersonalName: reservation.boatPersonalName).padding(.bottom, groupSpacing)
                
                if (reservationDetailsAreValid()){
                    Group {
                        Text("Info acceptee").font(groupTitleFont).foregroundColor(groupTitleColor)
                        Text("Name: \(reservationDetails!.currentBatteryUserName!)")
                        Text("Tel.: \(reservationDetails!.currentHolderPhoneNumber!)")
                        Text("E-mail: \(reservationDetails!.currentHolderEmail!)")
                            .padding(.bottom, groupSpacing)
                    }
                    
                    Group {
                        Text("Adres").font(groupTitleFont).foregroundColor(groupTitleColor)
                        Text("\(reservationDetails!.currentHolderStreet!) \(reservationDetails!.currentHolderNumber!)")
                        Text("\(reservationDetails!.currentHolderPostalCode!) \(reservationDetails!.currentHolderCity!)")
                            .padding(.bottom, groupSpacing)
                    }
                    
                    
                    if (!(reservationDetails?.mentorName?.isEmpty ?? true)) {
                        Text(
                            "Meter/Peter"
                        ).font(groupTitleFont).foregroundColor(groupTitleColor)
                        Text((reservationDetails?.mentorName!)!)
                    }
                }
                Spacer()
            }.padding(padding)
            Spacer()
        }
    }
    
    func reservationDetailsAreValid() -> Bool {
        return !(
            reservationDetails?.currentBatteryUserName?.isEmpty ?? true ||
            reservationDetails?.currentHolderPhoneNumber?.isEmpty ?? true ||
            reservationDetails?.currentHolderEmail?.isEmpty ?? true ||
            reservationDetails?.currentHolderStreet?.isEmpty ?? true ||
            reservationDetails?.currentHolderNumber?.isEmpty ?? true ||
            reservationDetails?.currentHolderCity?.isEmpty ?? true ||
            reservationDetails?.currentHolderPostalCode?.isEmpty ?? true
        )
    }
}

#Preview {
    ReservationDetail(
        reservation: Reservation(start: Date(), end: Date(), date: Date(), boatId: 1, boatPersonalName: "boatName", id: 0, isDeleted: false),
        reservationDetails: ReservationDetails(mentorName: "mentor", batteryId: 1, currentBatteryUserName: "username", currentBatteryUserId: 1, currentHolderPhoneNumber: "phonenumber", currentHolderEmail: "email", currentHolderStreet: "street", currentHolderNumber: "number", currentHolderCity: "city", currentHolderPostalCode: "postalCode")
    )
}
