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
    
    private func processResponse(response: URLResponse?) -> Int?{
        guard let httpResponse = response as? HTTPURLResponse else {
            return nil
        }
        return httpResponse.statusCode
    }
    
    func processLoginResponse(response: URLResponse?, error: Error?) -> ResultModel{
        //Process error first
        let errorResultModel = processError(error: error)
        if(!errorResultModel.result)
        {
            return errorResultModel
        }        
        //Now process response
        var resultModel = ResultModel(result: true, message: "")
        if let statusCode = processResponse(response: response){
            switch statusCode{
            case 200:
                break
            case 401:
                resultModel.result = false
                resultModel.message = "Invalid username or password"
                break
            case 403:
                resultModel.result = false
                resultModel.message = "Forbidden"
                break
            case 404:
                resultModel.result = false
                resultModel.message = "Not found"
                break
            default: break
            }
        } else{
            resultModel.result = false
            resultModel.message = "Invalid response \(response)"
        }
        
        return resultModel
    }
    
    func processCreateAccountResponse(data: Data?, response: URLResponse?, error: Error?) -> ResultModel{
        //Process error first
        let errorResultModel = processError(error: error)
        if(!errorResultModel.result)
        {
            return errorResultModel
        }
        //Now process response
        var resultModel = ResultModel(result: true, message: "")
        if let statusCode = processResponse(response: response){
            switch statusCode{
            case 200, 201:
                break
            case 401:
                resultModel.result = false
                resultModel.message = "Unauthorized"
                break
            case 403:
                resultModel.result = false
                resultModel.message = "Forbidden"
                break
            case 404:
                resultModel.result = false
                resultModel.message = "Not Found"                
                break
            case 409:
                resultModel.result = false
//                do{
//                    var responseJson = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
//                    if let rJson = responseJson {
//                        resultModel.message = rJson["message"] as? String ?? ""
//                    }
//                }catch let error{
//                    resultModel.message = "Username conflict"
//                }
                var responseJson = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                if let rJson = responseJson {
                    resultModel.message = (rJson!["message"] as? String)!
                }else{
                    resultModel.message = "Username conflict"
                }
                break
            default: break
            }
        } else{
            resultModel.result = false
            resultModel.message = "Invalid response \(response)"
        }
        
        return resultModel
    }
    
    func processForgotPasswordResponse(response: URLResponse?, error: Error?) -> ResultModel{
        //Process error first
        let errorResultModel = processError(error: error)
        if(!errorResultModel.result)
        {
            return errorResultModel
        }
        //Now process response
        var resultModel = ResultModel(result: true, message: "")
        if let statusCode = processResponse(response: response){
            switch statusCode{
            case 200:
                break
            case 401:
                resultModel.result = false
                resultModel.message = "Invalid username or password"
                break
            case 403:
                resultModel.result = false
                resultModel.message = "Forbidden"
                break
            case 404:
                resultModel.result = false
                resultModel.message = "Not found"
                break
            default: break
            }
        } else{
            resultModel.result = false
            resultModel.message = "Invalid response \(response)"
        }
        
        return resultModel
    }
    
    func processUserDetailsResponse(data:Data?, response: URLResponse?, error: Error?) -> ResultModel {
        //Process error first
        let errorResultModel = processError(error: error)
        if(!errorResultModel.result)
        {
            return errorResultModel
        }
        //Now process response
        var resultModel = ResultModel(result: true, message: "")
        if let statusCode = processResponse(response: response){
            switch statusCode{
            case 200:
                break
            case 401:
                resultModel.result = false
                resultModel.message = "Invalid username or password"
                break
            case 403:
                resultModel.result = false
                resultModel.message = "Forbidden"
                break
            case 404:
                resultModel.result = false
                var responseJson = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                if let rJson = responseJson {
                    resultModel.message = (rJson!["message"] as? String)!
                }else{
                    resultModel.message = "No data found for the user"
                }
                break
            default: break
            }
        } else{
            resultModel.result = false
            resultModel.message = "Invalid response \(response)"
        }
        
        return resultModel
    }
    
    func processUpdateUserDetailsResponse(data:Data?, response: URLResponse?, error: Error?) -> ResultModel {
        //Process error first
        let errorResultModel = processError(error: error)
        if(!errorResultModel.result)
        {
            return errorResultModel
        }
        //Now process response
        var resultModel = ResultModel(result: true, message: "")
        if let statusCode = processResponse(response: response){
            switch statusCode{
            case 200:
                break
            case 401:
                resultModel.result = false
                resultModel.message = "Invalid username or password"
                break
            case 403:
                resultModel.result = false
                resultModel.message = "Forbidden"
                break
            case 404:
                resultModel.result = false
                var responseJson = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                if let rJson = responseJson {
                    resultModel.message = (rJson!["message"] as? String)!
                }else{
                    resultModel.message = "No data found for the user"
                }
                break
            default: break
            }
        } else{
            resultModel.result = false
            resultModel.message = "Invalid response \(response)"
        }
        
        return resultModel
    }
    
    func processUserHospitalsResponse(data:Data?, response: URLResponse?, error: Error?) -> ResultModel {
        //Process error first
        let errorResultModel = processError(error: error)
        if(!errorResultModel.result)
        {
            return errorResultModel
        }
        //Now process response
        var resultModel = ResultModel(result: true, message: "")
        if let statusCode = processResponse(response: response){
            switch statusCode{
            case 200:
                break
            case 401:
                resultModel.result = false
                resultModel.message = "Invalid username or password"
                break
            case 403:
                resultModel.result = false
                resultModel.message = "Forbidden"
                break
            case 404:
                resultModel.result = false
                var responseJson = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                if let rJson = responseJson {
                    resultModel.message = (rJson!["message"] as? String)!
                }else{
                    resultModel.message = "No data found for the user"
                }
                break
            default: break
            }
        } else{
            resultModel.result = false
            resultModel.message = "Invalid response \(response)"
        }
        
        return resultModel
    }
    
    func processPostUserHospitalResponse(data:Data?, response: URLResponse?, error: Error?) -> ResultModel {
        //Process error first
        let errorResultModel = processError(error: error)
        if(!errorResultModel.result)
        {
            return errorResultModel
        }
        //Now process response
        var resultModel = ResultModel(result: true, message: "")
        if let statusCode = processResponse(response: response){
            switch statusCode{
            case 200:
                break
            case 401:
                resultModel.result = false
                resultModel.message = "Invalid username or password"
                break
            case 403:
                resultModel.result = false
                resultModel.message = "Forbidden"
                break
            case 404:
                resultModel.result = false
                var responseJson = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                if let rJson = responseJson {
                    resultModel.message = (rJson!["message"] as? String)!
                }else{
                    resultModel.message = "No data found for the user"
                }
                break
            default: break
            }
        } else{
            resultModel.result = false
            resultModel.message = "Invalid response \(response)"
        }
        
        return resultModel
    }
}
