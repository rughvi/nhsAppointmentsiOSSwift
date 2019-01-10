//
//  CreateAccountViewController.swift
//  SwiftAppointments
//
//  Created by Venkata Vadigepalli on 31/12/2018.
//  Copyright © 2018 vvrmobilesolutions. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    
    @IBAction func loginClick(_ sender: UIButton) {
        resetFields()
        performSegue(withIdentifier: "unwindToLoginViewController", sender: self)
    }
    
    @IBAction func submitClick(_ sender: UIButton) {
        guard let firstname = firstnameTextField.text,
              let lastname = lastnameTextField.text,
              let dob = dobTextField.text,
              let email = emailTextField.text,
              let username = usernameTextField.text,
              let password = passwordTextField.text,
              let confirmPassword = confirmPasswordTextField.text,
              !firstname.isEmpty && !lastname.isEmpty && !dob.isEmpty && !email.isEmpty &&
              !username.isEmpty && !password.isEmpty && !confirmPassword.isEmpty else {
                let alertViewController = UIAlertController(title: "", message: "Please enter value for all fields", preferredStyle: .alert)
                alertViewController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertViewController, animated: true, completion: nil)
                return
        }
        
        guard password == confirmPassword else {
            let alertViewController = UIAlertController(title: "", message: "Passwords do not match", preferredStyle: .alert)
            alertViewController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertViewController, animated: true, completion: nil)
            return
        }
        
        self.loginManager?.createAccount(username: username, password: password, firstname: firstname, lastname: lastname, email: email, dob: dob) { resultModel in
            DispatchQueue.main.async {
                if(!resultModel.result){
                    let alertViewController = UIAlertController(title: "", message: resultModel.message, preferredStyle: .alert)
                    alertViewController.addAction(UIAlertAction(title: "OK", style:.cancel, handler: nil))
                    self.present(alertViewController, animated: true, completion: nil)
                    return
                }
                else{
                    let alertViewController = UIAlertController(title: "", message: "You have successfully registered", preferredStyle: .alert)
                    alertViewController.addAction(UIAlertAction(title: "OK", style:.cancel, handler: nil))
                    self.present(alertViewController, animated: true, completion: nil)
                    self.resetFields()
                }
            }
        }
    }
    
    var loginManager: LoginManager?
    private var datePicker: UIDatePicker?
    private var dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        dobTextField.inputView = datePicker
        
        let tapgestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped(tapgestureRecognizer:)))
        view.addGestureRecognizer(tapgestureRecognizer)
        
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
    
    private func resetFields(){
        usernameTextField.text = ""
        passwordTextField.text = ""
        confirmPasswordTextField.text = ""
        emailTextField.text = ""
        dobTextField.text = ""
        firstnameTextField.text = ""
        lastnameTextField.text = ""
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
