//
//  HospitalAppointmentResponseModel.swift
//  SwiftAppointments
//
//  Created by Venkata Vadigepalli on 21/01/2019.
//  Copyright © 2019 vvrmobilesolutions. All rights reserved.
//

import Foundation

struct HospitalAppointmentResponse : Codable {
    var id: Int
    var hospitalId: Int
    var hospitalName: String
    var appointments: [AppointmentModel]
}
