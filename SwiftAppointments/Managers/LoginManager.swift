//
//  LoginManager.swift
//  SwiftAppointments
//
//  Created by Venkata Vadigepalli on 30/12/2018.
//  Copyright © 2018 vvrmobilesolutions. All rights reserved.
//

import Foundation

protocol ILoginManager {
    func login(username: String?, password:String?, completion: @escaping (ResultModel) -> Void)
}

class LoginManager : ILoginManager{
    private var loginService: LoginService?
    private var appSession: AppSession
    
    init(loginService: LoginService, appSession: AppSession) {
        self.loginService = loginService;
        self.appSession = appSession
    }
    
    func login(username: String?, password: String?, completion: @escaping (ResultModel) -> Void) {
        guard let username = username,
            let password = password,
            !password.isEmpty && !username.isEmpty else {
                let resultModel = ResultModel(result: false, message: "Please provide all mandatory fields")
                completion(resultModel);
                return;
        }
        
        loginService?.login(username: username, password: password){resultModel, loginResponseModel in
            guard let loginResponseModel = loginResponseModel else {
                completion(resultModel)
                return
            }
            
            self.appSession.authToken = loginResponseModel.token
            self.appSession.userId = loginResponseModel.id
            self.appSession.username = username
            
            completion(resultModel)
        }
    }
    
    func createAccount(username: String, password: String, firstname: String, lastname: String, email: String, dob: String, completion: @escaping (ResultModel) -> Void){
        loginService?.createAccount(username: username, password: password, firstname: firstname, lastname: lastname, email: email, dob: dob, completion: completion)
    }
    
    func forgotPassword(username: String, completion: @escaping (ResultModel) -> Void) {
        loginService?.forgotPassword(username: username, completion: completion)
    }
}
