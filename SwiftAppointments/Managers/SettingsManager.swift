//
//  SettingsManager.swift
//  SwiftAppointments
//
//  Created by Venkata Vadigepalli on 01/01/2019.
//  Copyright © 2019 vvrmobilesolutions. All rights reserved.
//

import Foundation
class SettingsManager {
    private var settingsService: SettingsService?
    
    init(settingsService: SettingsService){
        self.settingsService = settingsService
    }
    
    func getUSerDetails(userId: Int, completion: @escaping (ResultModel, UserDetailsModel?) -> Void){
        settingsService?.getUserDetails(userId: userId, completion: completion)
    }
    
    func updateUserDetails(userId: Int, firstname: String, lastname: String, email: String, dob: String, completion: @escaping (ResultModel) -> Void){
        settingsService?.updateUserDetails(userId: userId, firstname: firstname, lastname: lastname, email: email, dob: dob, completion: completion)
    }
}
