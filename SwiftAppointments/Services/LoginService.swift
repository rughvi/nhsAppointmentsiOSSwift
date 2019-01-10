//
//  LoginService.swift
//  SwiftAppointments
//
//  Created by Venkata Vadigepalli on 30/12/2018.
//  Copyright © 2018 vvrmobilesolutions. All rights reserved.
//

import Foundation

class LoginService{
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
    
    func login(username:String, password: String, completion: @escaping (ResultModel, LoginResponseModel?) -> Void){
        
        guard let jsonData = jsonHandler.getLoginRequestBody(username: username, password: password) else{
            completion(ResultModel(result: false, message: "Unable to serialize username password object"), nil)
            return
        }
        var request = requestHandler.getLoginRequest()
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let resultModel: ResultModel? = self.responseHandler.processLoginResponse(response: response, error: error)
            guard let rm = resultModel, rm.result else{
                    completion(resultModel!, nil)
                    return
            }            
            //no error or no invalid response code.
            //process the data received
            guard let data = data else {
                completion(ResultModel(result: false, message: "No data received from the login service"), nil)
                return
            }
            
            guard let loginResponseModel = self.jsonHandler.getLoginResponseModel(data: data) else {
                completion(ResultModel(result: false, message: "Unable to deserialize response from login service"), nil)
                return
            }
            
            completion(ResultModel(result: true, message: ""), loginResponseModel)            
        }
        task.resume()
    }
    
    func createAccount(username: String, password: String, firstname: String, lastname: String, email: String, dob: String, completion: @escaping (ResultModel) -> Void) {
        guard let jsonData = jsonHandler.getCreateAccountRequestBody(username: username, password: password, firstname: firstname, lastname: lastname, email: email, dob: dob) else{
            completion(ResultModel(result: false, message: "Unable to serialize data"))
            return
        }
        
        var request = requestHandler.getCreateAccountRequest()
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let resultModel: ResultModel? = self.responseHandler.processCreateAccountResponse(data:data, response: response, error: error)
            guard let rm = resultModel, rm.result else{
                completion(resultModel!)
                return
            }
            //no error or no invalid response code.
            //process the data received
            guard let data = data else {
                completion(ResultModel(result: false, message: "No data received from the create account service"))
                return
            }
            
            completion(ResultModel(result: true, message: ""))
        }
        task.resume()
    }
    
    func forgotPassword(username: String, completion: @escaping (ResultModel) -> Void) {
        var request = requestHandler.getForgotPasswordRequest(username: username)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let resultModel: ResultModel? = self.responseHandler.processForgotPasswordResponse(response: response, error: error)
            guard let rm = resultModel, rm.result else{
                completion(resultModel!)
                return
            }
            
        }
        task.resume()
    }
}
