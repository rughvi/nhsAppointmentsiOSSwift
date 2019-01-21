//
//  AppointmentModel.swift
//  SwiftAppointments
//
//  Created by Venkata Vadigepalli on 21/01/2019.
//  Copyright © 2019 vvrmobilesolutions. All rights reserved.
//

import Foundation

struct AppointmentModel: Codable{
    var id: Int
    var dateOfAppointment: String
    var timeOfAppointment: String    
}
