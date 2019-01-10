//
//  PrinterController.swift
//  SwiftAppointments
//
//  Created by Venkata Vadigepalli on 10/01/2019.
//  Copyright © 2019 vvrmobilesolutions. All rights reserved.
//

import Foundation
import UIKit

class PrinterController {
    func print(pdfFileLocalUrl: URL?, completion: @escaping (Bool, Error?) -> Void){
        if let fileUrl = pdfFileLocalUrl {
            if UIPrintInteractionController.canPrint(fileUrl){
                let printInfo = UIPrintInfo(dictionary: nil)
                printInfo.jobName = fileUrl.lastPathComponent
                printInfo.outputType = .general
                
                let printController = UIPrintInteractionController.shared
                printController.printInfo = printInfo
                printController.showsNumberOfCopies = false
                printController.printingItem = fileUrl
                printController.present(animated: true){controller, success, error in
                    completion(success, error)
//                    if(success){
//                        let alertViewController = UIAlertController(title: "", message: "Document printed successfully", preferredStyle: .alert)
//                        alertViewController.addAction(UIAlertAction(title: "OK", style:.cancel, handler: nil))
//                        self.present(alertViewController, animated: true, completion: nil)
//                    }
//                    else {
//
//                    }
                }
            }
            else{
                completion(false, CustomError("Can not print the document"))
//                let alertViewController = UIAlertController(title: "", message: "Can not print the document", preferredStyle: .alert)
//                alertViewController.addAction(UIAlertAction(title: "OK", style:.cancel, handler: nil))
//                self.present(alertViewController, animated: true, completion: nil)
            }
        }
    }
}
