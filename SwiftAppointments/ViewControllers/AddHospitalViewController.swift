//
//  AddHospitalViewController.swift
//  SwiftAppointments
//
//  Created by Venkata Vadigepalli on 10/01/2019.
//  Copyright © 2019 vvrmobilesolutions. All rights reserved.
//

import UIKit

class AddHospitalViewController: UIViewController {

    @IBOutlet weak var hospitalNumberTextField: UITextField!
    
    @IBOutlet weak var hospitalNameTextField: UITextField!
    
    var hospitalManager: HospitalsManager?
    var appSession: AppSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addClick(_ sender: Any) {
        guard let hospitalId = hospitalNumberTextField.text,
              let hospitalName = hospitalNameTextField.text,
            !hospitalId.isEmpty, !hospitalName.isEmpty else {
                let alertViewController = UIAlertController(title: "", message: "Enter values for all fields", preferredStyle: .alert)
                alertViewController.addAction(UIAlertAction(title: "OK", style:.cancel, handler: nil))
                self.present(alertViewController, animated: true, completion: nil)
                return
        }
        
        hospitalManager?.addHospitalToUser(userId: (appSession?.userId)!, hospitalId: hospitalId, hospitalName: hospitalName){resultModel in
            if(!resultModel.result){
                let alertViewController = UIAlertController(title: "", message: resultModel.message, preferredStyle: .alert)
                alertViewController.addAction(UIAlertAction(title: "OK", style:.cancel, handler: nil))
                self.present(alertViewController, animated: true, completion: nil)
                return
            }
            
            self.performSegue(withIdentifier: "unwindToHomeViewController", sender: nil)
        }
    }
    
    @IBAction func backClick(_ sender: Any) {
        performSegue(withIdentifier: "unwindToHomeViewController", sender: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
