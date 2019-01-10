//
//  SettingsViewController.swift
//  SwiftAppointments
//
//  Created by Venkata Vadigepalli on 01/01/2019.
//  Copyright © 2019 vvrmobilesolutions. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    
    @IBAction func backClick(_ sender: Any) {
        performSegue(withIdentifier: "unwindToHomeViewController", sender: nil)
    }
    
    @IBAction func updateClick(_ sender: Any) {
        guard let firstname = firstnameTextField.text,
            let lastname = lastnameTextField.text,
            let dob = dobTextField.text,
            let email = emailTextField.text,
            let username = usernameTextField.text,
            !firstname.isEmpty && !lastname.isEmpty && !dob.isEmpty && !email.isEmpty &&
                !username.isEmpty else {
                    let alertViewController = UIAlertController(title: "", message: "Please enter value for all fields", preferredStyle: .alert)
                    alertViewController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alertViewController, animated: true, completion: nil)
                    return
        }
        
        settingsManager?.updateUserDetails(userId: (appSession?.userId!)!, firstname: firstname, lastname: lastname, email: email, dob: dob){ resultModel in
            DispatchQueue.main.async {[weak self] in
                if !resultModel.result {
                    let alertViewController = UIAlertController(title: "", message: resultModel.message, preferredStyle: .alert)
                    alertViewController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self?.present(alertViewController, animated: true, completion: nil)
                    
                    return
                }
                self?.firstnameTextField.text = ""
                self?.lastnameTextField.text = ""
                self?.usernameTextField.text = ""
                self?.dobTextField.text = ""
                self?.emailTextField.text = ""
                self?.performSegue(withIdentifier: "unwindToHomeViewController", sender: nil)
            }
            
        }
    }
    
    private var datePicker: UIDatePicker?
    private var dateFormatter = DateFormatter()
    
    var settingsManager: SettingsManager?
    var appSession: AppSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        dobTextField.inputView = datePicker
        
        let tapgestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped(tapgestureRecognizer:)))
        view.addGestureRecognizer(tapgestureRecognizer)
        
        settingsManager?.getUSerDetails(userId: (appSession?.userId!)!) {resultModel, userDetailsModel in
            guard let userDetailsModel = userDetailsModel else {
                let alertViewController = UIAlertController(title: "", message: resultModel.message, preferredStyle: .alert)
                alertViewController.addAction(UIAlertAction(title: "OK", style:.cancel, handler: nil))
                self.present(alertViewController, animated: true, completion: nil)
                return
            }
            DispatchQueue.main.async {[weak self] in
                self?.firstnameTextField.text = userDetailsModel.firstname
                self?.lastnameTextField.text = userDetailsModel.lastname
                self?.usernameTextField.text = userDetailsModel.username
                self?.emailTextField.text = userDetailsModel.email
                self?.dobTextField.text = userDetailsModel.dob
            }
        }
        // Do any additional setup after loading the view.
    }
    
    @objc func viewTapped(tapgestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        dobTextField.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
