//
//  HospitalsService.swift
//  SwiftAppointments
//
//  Created by Venkata Vadigepalli on 02/01/2019.
//  Copyright © 2019 vvrmobilesolutions. All rights reserved.
//

import Foundation
class HospitalsService {
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
    
    func getUserHospitals(userId: Int, completion: @escaping (ResultModel, [HospitalAppointmentModel]?) -> Void) {
        var request = requestHandler.getUserHospitalsRequest(userId: userId)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let resultModel: ResultModel? = self.responseHandler.processUserHospitalsResponse(data:data, response: response, error: error)
            guard let rm = resultModel, rm.result else{
                completion(resultModel!, nil)
                return
            }
            //no error or no invalid response code.
            //process the data received
            guard let data = data else {
                completion(ResultModel(result: false, message: "No data received from the user hospitals service"), nil)
                return
            }
            
            guard let userHospitalsResponseModel = self.jsonHandler.getUserHospitalsResponseModel(data: data) else {
                completion(ResultModel(result: false, message: "Unable to deserialize response from user hospitals service"), nil)
                return
            }
            
            completion(ResultModel(result: true, message: ""), userHospitalsResponseModel)
        }
        task.resume()
    }
    
    func addUserHospital(userId: Int, hospitalId: String, hospitalName: String, completion: @escaping(ResultModel) -> Void){
        guard let jsonData = jsonHandler.getPostUserHospitalRequestBody(hospitalId: hospitalId, hospitalName: hospitalName) else{
            completion(ResultModel(result: false, message: "Unable to serialize hospital details object"))
            return
        }
        
        var request = requestHandler.postUserHospitalRequest(userId: userId)
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let resultModel: ResultModel? = self.responseHandler.processPostUserHospitalResponse(data: data, response: response, error: error)
            guard let rm = resultModel, rm.result else{
                completion(resultModel!)
                return
            }
            //no error or no invalid response code.
            //process the data received
            guard let data = data else {
                completion(ResultModel(result: false, message: "No data received from the login service"))
                return
            }
            
            completion(ResultModel(result: true, message: ""))
        }
        task.resume()
    }
}
