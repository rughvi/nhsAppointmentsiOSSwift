//
//  JSONHandler.swift
//  SwiftAppointments
//
//  Created by Venkata Vadigepalli on 31/12/2018.
//  Copyright © 2018 vvrmobilesolutions. All rights reserved.
//

import Foundation
class JSONHandler{
    func getLoginRequestBody(username: String, password: String) -> Data?{
        let data = ["username":username, "password":password]
        var jsonData: Data?
        do {
            jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            return jsonData
        } catch let error {
            print(error)
            return nil
        }
    }
    
    func getLoginResponseModel(data: Data) -> LoginResponseModel?{
        var responseJSON: [String: Any]?
        do{
            responseJSON = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            guard let rJson = responseJSON,
                  let id = rJson["id"] as? Int,
                  let token = rJson["token"] as? String,
                  let timeToLive = rJson["timeToLive"] as? Int else {
                return nil;
            }
            return LoginResponseModel(id: id, token: token, timeToLive: timeToLive)
        } catch let _ {
            return nil
        }
    }
    
    func getCreateAccountRequestBody(username: String, password: String, firstname: String, lastname: String, email: String, dob: String) -> Data?{
        let data = ["username":username, "password":password, "email":email, "firstName":firstname, "lastName":lastname, "dateOfBirth":dob]
        var jsonData: Data?
        do {
            jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            return jsonData
        } catch let error {
            print(error)
            return nil
        }
    }
    
    func getUserDetailsResponseModel(data: Data) -> UserDetailsModel? {
        var responseJSON: [String: Any]?
        do{
            responseJSON = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            guard let rJson = responseJSON,
                //let rJson = rJsonArr.first,
                let id = rJson["id"] as? Int,
                let username = rJson["username"] as? String,
                let email = rJson["email"] as? String,
                let firstname = rJson["firstName"] as? String,
                let lastname = rJson["lastName"] as? String,
                let dob = rJson["dateOfBirth"] as? String else {
                    return nil;
            }
            return UserDetailsModel(id: id, username: username, email: email, firstname: firstname, lastname: lastname, dob: dob)
        } catch let error{
            return nil
        }
    }
    
    func getUpdateUserDetailsRequestBody(firstname: String, lastname: String, email: String, dob: String) -> Data? {
        let data = ["email":email, "firstName":firstname, "lastName":lastname, "dateOfBirth":dob]
        var jsonData: Data?
        do {
            jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            return jsonData
        } catch let error {
            print(error)
            return nil
        }
    }
    
    func getUserHospitalsResponseModel(data: Data) -> [HospitalAppointmentModel]? {
        var hospitalsModel = [HospitalAppointmentModel]()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        var responseJSON: [Any]?
        do{
            responseJSON = try JSONSerialization.jsonObject(with: data, options: []) as? [Any]
            guard let responseJSONWrapped = responseJSON, responseJSONWrapped.count != 0 else {
                return hospitalsModel
            }
            
            for respJSON in responseJSONWrapped {
                let respJsonDict = respJSON as! [String:Any]
                let hospitalId = respJsonDict["hospitalId"] as! Int
                let hospitalName = respJsonDict["hospitalName"] as! String
                let appointments = respJsonDict["appointments"] as! [Any]
                
                for appointment in appointments {
                    let appointmentDict = appointment as! [String:Any]
                    let appointmentId = appointmentDict["id"] as! Int
                    let dateOfAppointment = appointmentDict["dateOfAppointment"] as! String
                    let timeOfAppointment = appointmentDict["timeOfAppointment"] as! String
                    //Finding day of appointment - need a better way of doing this for different locale
                    var dayOfAppointment = ""
                    if let date = dateFormatter.date(from: dateOfAppointment) {
                        switch Calendar.current.component(.weekday, from: date) {
                        case 1:
                            dayOfAppointment = "Sun"
                            break
                        case 2:
                            dayOfAppointment = "Mon"
                            break
                        case 3:
                            dayOfAppointment = "Tue"
                            break
                        case 4:
                            dayOfAppointment = "Wed"
                            break
                        case 5:
                            dayOfAppointment = "Thu"
                            break
                        case 6:
                            dayOfAppointment = "Fri"
                            break
                        case 7:
                            dayOfAppointment = "Sat"
                            break
                        default: break
                        }
                    }
                    let hospitalAppointmentModel = HospitalAppointmentModel(appointmentId: appointmentId, dateOfAppointment: dateOfAppointment, timeOfAppointment: timeOfAppointment, dayOfAppointment: dayOfAppointment, hospitalId: hospitalId, hospitalName: hospitalName)
                    
                    hospitalsModel.append(hospitalAppointmentModel)
                }                
            }
            
            return hospitalsModel
        } catch let error{
            return nil
        }
    }
    
    func getPostUserHospitalRequestBody(hospitalId: String, hospitalName: String) -> Data?{
        let data = ["hospitalId":hospitalId, "hospitalName":hospitalName]
        var jsonData: Data?
        do {
            jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            return jsonData
        } catch let error {
            print(error)
            return nil
        }
    }
}
