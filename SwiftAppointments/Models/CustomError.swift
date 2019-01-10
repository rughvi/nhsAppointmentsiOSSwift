//
//  CustomError.swift
//  SwiftAppointments
//
//  Created by Venkata Vadigepalli on 10/01/2019.
//  Copyright © 2019 vvrmobilesolutions. All rights reserved.
//

import Foundation
struct CustomError: Error {
    let message: String
    
    init(_ message: String) {
        self.message = message
    }
    
    public var localizedDescription: String {
        return message
    }
}
