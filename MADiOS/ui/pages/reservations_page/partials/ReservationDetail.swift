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
    
    private struct Constants {
        static let padding: CGFloat = 16
        static let groupSpacing: CGFloat = 8
        static let groupTitleColor: Color = Colors.primary
        static let groupTitleFont: Font = .title2
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading){
                Text("Reservation details").font(.title)
                ImportantReservationInfo(date: reservation.date, start: reservation.start, end: reservation.end, boatPersonalName: reservation.boatPersonalName).padding(.bottom, Constants.groupSpacing)
                
                if (reservationDetailsAreValid()){
                    accepteeInfo
                    address
                    if (!(reservationDetails?.mentorName?.isEmpty ?? true)) {
                        mentor
                    }
                }
                else {
                    detailsNotAvailable
                }
                cancelButton
                Spacer()
            }.padding(Constants.padding)
            Spacer()
        }
    }
    
    var accepteeInfo: some View {
        Group {
            Text("Info acceptee").font(Constants.groupTitleFont).foregroundColor(Constants.groupTitleColor)
            Text("Name: \(reservationDetails!.currentBatteryUserName!)")
            Text("Tel.: \(reservationDetails!.currentHolderPhoneNumber!)")
            Text("E-mail: \(reservationDetails!.currentHolderEmail!)")
                .padding(.bottom, Constants.groupSpacing)
        }
    }
    
    var address: some View {
        Group {
            Text("Adres").font(Constants.groupTitleFont).foregroundColor(Constants.groupTitleColor)
            Text("\(reservationDetails!.currentHolderStreet!) \(reservationDetails!.currentHolderNumber!)")
            Text("\(reservationDetails!.currentHolderPostalCode!) \(reservationDetails!.currentHolderCity!)")
                .padding(.bottom, Constants.groupSpacing)
        }
    }
    
    var mentor: some View {
        Group {
            Text(
                "Meter/Peter"
            ).font(Constants.groupTitleFont).foregroundColor(Constants.groupTitleColor)
            Text((reservationDetails?.mentorName!)!)
        }
    }
    
    var detailsNotAvailable: some View {
        VStack(alignment: .center) {
            Image(systemName: "info.circle")
                .resizable()
                .frame(width: 48, height: 48)
                .foregroundColor(Colors.primary)
                .padding(.top, 20)
            
            Spacer().frame(height: 8)
            
            Text("Geen ophaal informatie beschikbaar")
                .font(.body)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 20)
    }
    
    var cancelButton: some View {
        //TODO: functionality and layout
        Button(action: {
            //onCancelReservation(selectedReservation.id)
        }) {
            Text("Cancel reservation")
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        .disabled(false)
        .padding(.horizontal)
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


