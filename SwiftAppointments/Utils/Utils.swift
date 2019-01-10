//
//  Utils.swift
//  SwiftAppointments
//
//  Created by Venkata Vadigepalli on 30/12/2018.
//  Copyright © 2018 vvrmobilesolutions. All rights reserved.
//

import Foundation

class Utils {
    func getServerUrl() -> String{
        var serverUrl = ""
        
        if let serverUrl1 = UserDefaults.standard.string(forKey: "serverUrl") {
            serverUrl = serverUrl1
        }
        
        return serverUrl;
    }
}
