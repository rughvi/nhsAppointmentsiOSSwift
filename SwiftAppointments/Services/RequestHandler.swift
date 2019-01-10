//
//  RequestHandler.swift
//  SwiftAppointments
//
//  Created by Venkata Vadigepalli on 31/12/2018.
//  Copyright © 2018 vvrmobilesolutions. All rights reserved.
//

import Foundation

class RequestHandler{
    private var endpoints: Endpoints
    private var appSession: AppSession
    
    init(endpoints: Endpoints, appSession: AppSession){
        self.endpoints = endpoints
        self.appSession = appSession
    }
    
    private func getBaseRequest(url: String?) -> URLRequest?{
        let url = URL(string: url!)!
        var request = URLRequest(url: url)
        request.setValue("application/json;", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    func getLoginRequest() -> URLRequest{
        var request = getBaseRequest(url: endpoints.getLogin())!
        request.httpMethod = "POST"        
        return request
    }
    
    func getCreateAccountRequest() -> URLRequest {
        var request = getBaseRequest(url: endpoints.getCreateAccount())!
        request.httpMethod = "POST"
        return request
    }
    
    func getForgotPasswordRequest(username: String) -> URLRequest {
        var request = getBaseRequest(url: endpoints.getForgotPassword() + username)!
        request.httpMethod = "GET"
        return request
    }
    
    func getUserDetailsRequest(userId: Int) -> URLRequest {
        var request = getBaseRequest(url: endpoints.getUserDetails() + String(userId))!
        request.httpMethod = "GET"
        request.setValue("Bearer \(appSession.authToken!)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    func putUserDetailsRequest(userId: Int) -> URLRequest {
        var request = getBaseRequest(url: endpoints.getUserDetails() + String(userId))!
        request.httpMethod = "PUT"
        request.setValue("Bearer \(appSession.authToken!)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    func getUserHospitalsRequest(userId: Int) -> URLRequest {
        var request = getBaseRequest(url: endpoints.getUserHospitals(userId: String(userId)))!
        request.httpMethod = "GET"
        request.setValue("Bearer \(appSession.authToken!)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    func postUserHospitalRequest(userId: Int) -> URLRequest{
        var request = getBaseRequest(url: endpoints.postUserHospital(userId: String(userId)))!
        request.httpMethod = "POST"
        request.setValue("Bearer \(appSession.authToken!)", forHTTPHeaderField: "Authorization")
        return request
    }
}
