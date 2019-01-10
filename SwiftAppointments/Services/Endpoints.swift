//
//  Endpoints.swift
//  SwiftAppointments
//
//  Created by Venkata Vadigepalli on 30/12/2018.
//  Copyright © 2018 vvrmobilesolutions. All rights reserved.
//

import Foundation

class Endpoints {
    private var utils: Utils
    init(utils: Utils){
        self.utils = utils
    }
    
    private func rootUrl() -> String{
        return utils.getServerUrl()
    }
    
    func getLogin() -> String{
        return rootUrl() + "/authentication/generateToken"
    }
    
    func getCreateAccount() -> String {
        return rootUrl() + "/user"
    }
    
    func getForgotPassword() -> String {
        return rootUrl() + "/forgotPassword?username="
    }
    
    func getUserDetails() -> String {
        return rootUrl() + "/user/"
    }
    
    func getUserHospitals(userId: String) -> String {
        return rootUrl() + "/user/\(userId)/hospitals"
    }
    
    func postUserHospital(userId: String) -> String{
        return rootUrl() + "/user/\(userId)/hospital"
    }
}
