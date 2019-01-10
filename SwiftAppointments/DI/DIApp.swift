//
//  DIApp.swift
//  SwiftAppointments
//
//  Created by Venkata Vadigepalli on 30/12/2018.
//  Copyright © 2018 vvrmobilesolutions. All rights reserved.
//

import Foundation
import Swinject
import SwinjectAutoregistration

class DIApp{
    
    static func DIInitialise() -> Container{
        let container = Container()
        container.autoregister(AppSession.self, initializer: AppSession.init).inObjectScope(.container)
        container.autoregister(Utils.self, initializer: Utils.init)
        container.autoregister(Endpoints.self, initializer: Endpoints.init)
        container.autoregister(JSONHandler.self, initializer: JSONHandler.init)
        container.autoregister(RequestHandler.self, initializer: RequestHandler.init)
        container.autoregister(ResponseHandler.self, initializer: ResponseHandler.init)
        container.autoregister(LoginService.self, initializer: LoginService.init)
        container.autoregister(SettingsService.self, initializer: SettingsService.init)
        container.autoregister(HospitalsService.self, initializer: HospitalsService.init)
        container.autoregister(LoginManager.self, initializer: LoginManager.init)
        container.autoregister(SettingsManager.self, initializer: SettingsManager.init)
        container.autoregister(HospitalsManager.self, initializer: HospitalsManager.init)
        container.autoregister(FileDownloadManager.self, initializer: FileDownloadManager.init)
        
        container.autoregister(PrinterController.self, initializer: PrinterController.init)
        
        container.storyboardInitCompleted(LoginViewController.self){resolver, controller in
            controller.loginManager = resolver ~> LoginManager.self
            controller.utils = resolver ~> Utils.self
        }
        
        container.storyboardInitCompleted(HomeViewController.self){resolver, controller in
            controller.appSession = resolver ~> AppSession.self
            controller.hospitalsManager = resolver ~> HospitalsManager.self
            controller.fileDownloadManger = resolver ~> FileDownloadManager.self
            controller.printerController = resolver ~> PrinterController.self
        }
        
        container.storyboardInitCompleted(CreateAccountViewController.self){resolver, controller in
            controller.loginManager = resolver ~> LoginManager.self
        }
        
        container.storyboardInitCompleted(ForgotPasswordViewController.self){resolver, controller in
            controller.loginManager = resolver ~> LoginManager.self
        }
        
        container.storyboardInitCompleted(SettingsViewController.self){resolver, controller in
            controller.settingsManager = resolver ~> SettingsManager.self
            controller.appSession = resolver ~> AppSession.self
        }
        
        container.storyboardInitCompleted(DocumentViewController.self){resolver, controller in
            controller.printerController = resolver ~> PrinterController.self
        }
        
        container.storyboardInitCompleted(AddHospitalViewController.self){resolver, controller in
            controller.hospitalManager = resolver ~> HospitalsManager.self
            controller.appSession = resolver ~> AppSession.self
        }
        
        return container
    }
}
