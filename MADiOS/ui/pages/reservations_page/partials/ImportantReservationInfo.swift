//
//  ImportantReservationInfo.swift
//  MADiOS
//
//  Created by Bram Rampelberg on 02/01/2025.
//  Copyright © 2025 HOGENT. All rights reserved.
//

import SwiftUI

struct ImportantReservationInfo: View {
    let date: Date
    let start: Date
    let end: Date
    let boatPersonalName: String
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Date: \(date.formatted(.dateTime.day().month().year()))")
                .font(.title3)
            Text("\(start.formatted(.dateTime.hour().minute())) - \(end.formatted(.dateTime.hour().minute()))")
                .font(.system(.title))
            Text("Boat: \(boatPersonalName)")
        }
    }
}

#Preview {
    ImportantReservationInfo(date: Date(), start: Date(), end: Date(), boatPersonalName: "boatname")
}
