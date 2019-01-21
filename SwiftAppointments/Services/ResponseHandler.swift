//
//  ResponseHandler.swift
//  SwiftAppointments
//
//  Created by Venkata Vadigepalli on 31/12/2018.
//  Copyright © 2018 vvrmobilesolutions. All rights reserved.
//

import Foundation

class ResponseHandler{
    private func processError(error: Error?) -> ResultModel {
        if let error = error{
            return ResultModel(result: false, message: error.localizedDescription)
        }
        return ResultModel(result: true, message: "");
    }
    
    private func processResponse(response: URLResponse?) -> ResponseStatusModel{
        guard let httpResponse = response as? HTTPURLResponse else {
            return ResponseStatusModel(statusCode:-1, message: "Invalid response \(response)", result: false)
        }
        var responseStatusModel = ResponseStatusModel(statusCode: 200, message: "", result: true)
        switch httpResponse.statusCode {
        case 200,201:
            break
        case 401:
            responseStatusModel.statusCode = 401
            responseStatusModel.result = false
            responseStatusModel.message = "Unauthorized"
            break
        case 403:
            responseStatusModel.statusCode = 403
            responseStatusModel.result = false
            responseStatusModel.message = "Forbidden"
            break
        case 404:
            responseStatusModel.statusCode = 404
            responseStatusModel.result = false
            responseStatusModel.message = "Not found"
            break
        default: break
        }
        return responseStatusModel
    }
    
    func processLoginResponse(response: URLResponse?, error: Error?) -> ResultModel{
        //Process error first
        let errorResultModel = processError(error: error)
        if(!errorResultModel.result)
        {
            return errorResultModel
        }        
        //Now process response
        
        var responseStatusModel = processResponse(response: response)
        if(!responseStatusModel.result && responseStatusModel.statusCode == 401){
            responseStatusModel.message = "Invalid username or password"
        }
        return ResultModel(result:responseStatusModel.result, message: responseStatusModel.message)
    }
    
    func processCreateAccountResponse(data: Data?, response: URLResponse?, error: Error?) -> ResultModel{
        //Process error first
        let errorResultModel = processError(error: error)
        if(!errorResultModel.result)
        {
            return errorResultModel
        }
        //Now process response
        var responseStatusModel = processResponse(response: response)
        if(responseStatusModel.statusCode == 409){
            let responseJson = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
            if let rJson = responseJson {
                responseStatusModel.message = (rJson!["message"] as? String)!
            }else{
                responseStatusModel.message = "Username conflict"
            }
        }
        
        return ResultModel(result:responseStatusModel.result, message: responseStatusModel.message)
    }
    
    func processForgotPasswordResponse(response: URLResponse?, error: Error?) -> ResultModel{
        //Process error first
        let errorResultModel = processError(error: error)
        if(!errorResultModel.result)
        {
            return errorResultModel
        }
        //Now process response
        let responseStatusModel = processResponse(response: response)
        
        return ResultModel(result:responseStatusModel.result, message: responseStatusModel.message)
    }
    
    func processUserDetailsResponse(data:Data?, response: URLResponse?, error: Error?) -> ResultModel {
        //Process error first
        let errorResultModel = processError(error: error)
        if(!errorResultModel.result)
        {
            return errorResultModel
        }
        
        //Now process response
        var responseStatusModel = processResponse(response: response)
        if(responseStatusModel.statusCode == 404){
            var responseJson = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
            if let rJson = responseJson {
                responseStatusModel.message = (rJson!["message"] as? String)!
            }else{
                responseStatusModel.message = "No data found for the user"
            }
        }
        
        return ResultModel(result:responseStatusModel.result, message: responseStatusModel.message)
    }
    
    func processUpdateUserDetailsResponse(data:Data?, response: URLResponse?, error: Error?) -> ResultModel {
        //Process error first
        let errorResultModel = processError(error: error)
        if(!errorResultModel.result)
        {
            return errorResultModel
        }
        //Now process response
        var responseStatusModel = processResponse(response: response)
        if(responseStatusModel.statusCode == 404){
            var responseJson = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
            if let rJson = responseJson {
                responseStatusModel.message = (rJson!["message"] as? String)!
            }else{
                responseStatusModel.message = "No data found for the user"
            }
        }
        
        return ResultModel(result:responseStatusModel.result, message: responseStatusModel.message)
    }
    
    func processUserHospitalsResponse(data:Data?, response: URLResponse?, error: Error?) -> ResultModel {
        //Process error first
        let errorResultModel = processError(error: error)
        if(!errorResultModel.result)
        {
            return errorResultModel
        }
        //Now process response
        var responseStatusModel = processResponse(response: response)
        if(responseStatusModel.statusCode == 404){
            var responseJson = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
            if let rJson = responseJson {
                responseStatusModel.message = (rJson!["message"] as? String)!
            }else{
                responseStatusModel.message = "No data found for the user"
            }
        }
        
        return ResultModel(result:responseStatusModel.result, message: responseStatusModel.message)
    }
    
    func processPostUserHospitalResponse(data:Data?, response: URLResponse?, error: Error?) -> ResultModel {
        //Process error first
        let errorResultModel = processError(error: error)
        if(!errorResultModel.result)
        {
            return errorResultModel
        }
        //Now process response
        var responseStatusModel = processResponse(response: response)
        if(responseStatusModel.statusCode == 404){
            var responseJson = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
            if let rJson = responseJson {
                responseStatusModel.message = (rJson!["message"] as? String)!
            }else{
                responseStatusModel.message = "No data found for the user"
            }
        }
        
        return ResultModel(result:responseStatusModel.result, message: responseStatusModel.message)
    }
}
