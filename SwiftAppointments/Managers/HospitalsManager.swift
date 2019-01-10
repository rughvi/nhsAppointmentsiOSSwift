//
//  HospitalsManager.swift
//  SwiftAppointments
//
//  Created by Venkata Vadigepalli on 02/01/2019.
//  Copyright © 2019 vvrmobilesolutions. All rights reserved.
//

import Foundation
class HospitalsManager{
    private var hospitalsService: HospitalsService?
    
    init(hospitalsService: HospitalsService){
        self.hospitalsService = hospitalsService
    }
    
    func getUserHospitals(userId: Int, completion: @escaping(ResultModel, [HospitalAppointmentModel]?) -> Void){
        hospitalsService?.getUserHospitals(userId: userId, completion: completion)
    }
    
    func addHospitalToUser(userId: Int, hospitalId: String, hospitalName: String, completion: @escaping (ResultModel) -> Void){
        hospitalsService?.addUserHospital(userId: userId, hospitalId: hospitalId, hospitalName: hospitalName, completion: completion)
    }
}
