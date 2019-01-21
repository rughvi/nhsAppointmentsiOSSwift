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
        do{
            let decoder = JSONDecoder()
            let response = try decoder.decode(LoginResponseModel.self, from: data)
            return response
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
        do{
            let decoder = JSONDecoder()
            let response = try decoder.decode(UserDetailsModel.self, from: data)
            return response
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
        do{
            let decoder = JSONDecoder()
            let hospitalAppointmentResponse = try decoder.decode([HospitalAppointmentResponse].self, from: data)
            
            for hospitalAppointment in hospitalAppointmentResponse {
                for appointmentModel in hospitalAppointment.appointments{
                    var hospitalAppointmentModel = HospitalAppointmentModel(
                        appointmentId: appointmentModel.id,
                        dateOfAppointment: appointmentModel.dateOfAppointment,
                        timeOfAppointment:appointmentModel.timeOfAppointment,
                        dayOfAppointment:"",
                        hospitalId : hospitalAppointment.hospitalId,
                        hospitalName: hospitalAppointment.hospitalName
                    )
                    hospitalAppointmentModel.dayOfAppointment = getDayFromDate(dateOfAppointment: hospitalAppointmentModel.dateOfAppointment)
                    
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
        
    func getDayFromDate(dateOfAppointment: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
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
        
        return dayOfAppointment
    }
}
