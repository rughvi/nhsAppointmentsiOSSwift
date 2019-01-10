//
//  SettingsService.swift
//  SwiftAppointments
//
//  Created by Venkata Vadigepalli on 01/01/2019.
//  Copyright © 2019 vvrmobilesolutions. All rights reserved.
//

import Foundation
class SettingsService{
    private var endpoints: Endpoints
    private var responseHandler: ResponseHandler
    private var requestHandler: RequestHandler
    private var jsonHandler: JSONHandler
    
    init(endpoints: Endpoints, responseHandler: ResponseHandler, requestHandler: RequestHandler, jsonHandler:JSONHandler) {
        self.endpoints = endpoints
        self.requestHandler = requestHandler
        self.responseHandler = responseHandler
        self.jsonHandler = jsonHandler
    }
    
    func getUserDetails(userId: Int, completion: @escaping (ResultModel, UserDetailsModel?) -> Void) {
        var request = requestHandler.getUserDetailsRequest(userId: userId)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let resultModel: ResultModel? = self.responseHandler.processUserDetailsResponse(data:data, response: response, error: error)
            guard let rm = resultModel, rm.result else{
                completion(resultModel!, nil)
                return
            }
            //no error or no invalid response code.
            //process the data received
            guard let data = data else {
                completion(ResultModel(result: false, message: "No data received from the user details service"), nil)
                return
            }
            
            guard let userDetailsResponseModel = self.jsonHandler.getUserDetailsResponseModel(data: data) else {
                completion(ResultModel(result: false, message: "Unable to deserialize response from user details service"), nil)
                return
            }
            
            completion(ResultModel(result: true, message: ""), userDetailsResponseModel)
        }
        task.resume()
    }
    
    func updateUserDetails(userId: Int, firstname: String, lastname: String, email: String, dob: String, completion: @escaping (ResultModel) -> Void) {
        guard let jsonData = jsonHandler.getUpdateUserDetailsRequestBody(firstname: firstname, lastname: lastname, email: email, dob: dob) else{
            completion(ResultModel(result: false, message: "Unable to serialize user details object"))
            return
        }
        
        var request = requestHandler.putUserDetailsRequest(userId: userId)
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let resultModel: ResultModel? = self.responseHandler.processUpdateUserDetailsResponse(data:data, response: response, error: error)
            guard let rm = resultModel, rm.result else{
                completion(resultModel!)
                return
            }
            //no error or no invalid response code.
            
            completion(ResultModel(result: true, message: ""))
        }
        task.resume()
    }
}
