//
//  LoginResponseModel.swift
//  SwiftAppointments
//
//  Created by Venkata Vadigepalli on 31/12/2018.
//  Copyright © 2018 vvrmobilesolutions. All rights reserved.
//

import Foundation

struct LoginResponseModel: Codable{
    var id:Int
    var token:String
    var timeToLive:Int
    
}
