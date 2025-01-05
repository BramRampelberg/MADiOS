//
//  ReservationDetail.swift
//  MADiOS
//
//  Created by Bram Rampelberg on 02/01/2025.
//  Copyright © 2025 HOGENT. All rights reserved.
//

import SwiftUI

struct ReservationDetail: View {
    @EnvironmentObject var reservationViewModel: ReservationsViewModel
    let reservation: Reservation
    let reservationDetails: ReservationDetails?
    let isReservationCancelable: Bool
    
    private struct Constants {
        static let padding: CGFloat = 16
        static let groupSpacing: CGFloat = 8
        static let groupTitleColor: Color = Colors.primary
        static let groupTitleFont: Font = .title2
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0){
                Text("Reservation details").font(.title)
                ImportantReservationInfo(date: reservation.date, start: reservation.start, end: reservation.end, boatPersonalName: reservation.boatPersonalName).padding(.bottom, Constants.groupSpacing)
                
                if (reservationDetailsAreValid()){
                    accepteeInfo.padding(.bottom, Constants.groupSpacing)
                    address.padding(.bottom, Constants.groupSpacing)
                    if (!(reservationDetails?.mentorName?.isEmpty ?? true)) {
                        mentor
                    }
                }
                else {
                    detailsNotAvailable.padding(.top, Constants.padding)
                }
                Spacer()
                
                if (reservationViewModel.isCancelationPending || reservationViewModel.hasCancelError){
                    HStack {
                        Spacer()
                        VStack {
                            if reservationViewModel.isCancelationPending {
                                ProgressView()
                            }
                            if reservationViewModel.hasCancelError {
                                Text(reservationViewModel.cancelErrorDescription!)
                                    .foregroundColor(Colors.red)
                                    .multilineTextAlignment(.center)
                            }
                        }
                        Spacer()
                    }
                }
                cancelButton.padding(.top, Constants.padding)
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
        }
    }
    
    var address: some View {
        Group {
            Text("Adres").font(Constants.groupTitleFont).foregroundColor(Constants.groupTitleColor)
            Text("\(reservationDetails!.currentHolderStreet!) \(reservationDetails!.currentHolderNumber!)")
            Text("\(reservationDetails!.currentHolderPostalCode!) \(reservationDetails!.currentHolderCity!)")
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
            Image(systemName: "info.circle.fill")
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
    }
    
    var cancelButton: some View {
        Button(action: {
            reservationViewModel.cancelReservation()
        }) {
            Text(isReservationCancelable ? "Cancel reservation" : "Not cancelable")
                .frame(maxWidth: .infinity)
                .padding()
                .background(isReservationCancelable ? Colors.red : .gray)
                .foregroundColor(.white)
                .cornerRadius(100)
        }
        .disabled(!isReservationCancelable)
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
        reservationDetails: ReservationDetails(mentorName: "mentor", batteryId: 1, currentBatteryUserName: "username", currentBatteryUserId: 1, currentHolderPhoneNumber: "phonenumber", currentHolderEmail: "email", currentHolderStreet: "street", currentHolderNumber: "number", currentHolderCity: "city", currentHolderPostalCode: "postalCode"),
        isReservationCancelable: true
    )
}


