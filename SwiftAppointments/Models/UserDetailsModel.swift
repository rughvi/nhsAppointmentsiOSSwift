//
//  UserDetailsModel.swift
//  SwiftAppointments
//
//  Created by Venkata Vadigepalli on 02/01/2019.
//  Copyright © 2019 vvrmobilesolutions. All rights reserved.
//

import Foundation
struct UserDetailsModel: Codable {
    var id: Int
    var username: String
    var email: String
    var firstname: String
    var lastname: String
    var dob: String
    
    enum CodingKeys: String, CodingKey{
        case id = "id"
        case username = "username"
        case email = "email"
        case firstname = "firstName"
        case lastname = "lastName"
        case dob="dateOfBirth"
    }
}
