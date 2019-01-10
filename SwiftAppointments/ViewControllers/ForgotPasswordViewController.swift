//
//  ForgotPasswordViewController.swift
//  SwiftAppointments
//
//  Created by Venkata Vadigepalli on 01/01/2019.
//  Copyright © 2019 vvrmobilesolutions. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBAction func loginClick(_ sender: Any) {
        usernameTextField.text = ""
        performSegue(withIdentifier: "unwindToLoginViewController", sender: self)
    }
    
    @IBAction func resetPasswordClick(_ sender: Any) {
        guard  let username = usernameTextField.text, !username.isEmpty else {
            let alertViewController = UIAlertController(title: "", message: "Please enter username", preferredStyle: .alert)
            alertViewController.addAction(UIAlertAction(title: "OK", style:.cancel, handler: nil))
            self.present(alertViewController, animated: true, completion: nil)
            return
        }
        
        let usernameArr = username.components(separatedBy: " ")
        if(usernameArr.count > 1){
            let alertViewController = UIAlertController(title: "", message: "Invalid username", preferredStyle: .alert)
            alertViewController.addAction(UIAlertAction(title: "OK", style:.cancel, handler: nil))
            self.present(alertViewController, animated: true, completion: nil)
            return
        }
        
        loginManager?.forgotPassword(username: username){resultModel in
            DispatchQueue.main.async {
                if(!resultModel.result){
                    let alertViewController = UIAlertController(title: "", message: resultModel.message, preferredStyle: .alert)
                    alertViewController.addAction(UIAlertAction(title: "OK", style:.cancel, handler: nil))
                    self.present(alertViewController, animated: true, completion: nil)
                }
                else{
                    let alertViewController = UIAlertController(title: "", message: "We have sent an email. Please follow instructions in the email.", preferredStyle: .alert)
                    alertViewController.addAction(UIAlertAction(title: "OK", style:.cancel, handler: nil))
                    self.present(alertViewController, animated: true, completion: nil)
                    self.usernameTextField.text = ""
                }
            }
        }
    }
    
    var loginManager: LoginManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
