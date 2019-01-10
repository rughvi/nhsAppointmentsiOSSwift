//
//  AppSession.swift
//  SwiftAppointments
//
//  Created by Venkata Vadigepalli on 31/12/2018.
//  Copyright © 2018 vvrmobilesolutions. All rights reserved.
//

import Foundation
class AppSession{
    var authToken: String?
    var userId: Int?
    var username:String?
    
    func clearSession(){
        authToken = ""
        userId = nil
        username = ""
    }
}
