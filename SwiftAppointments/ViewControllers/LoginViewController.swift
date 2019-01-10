//
//  LoginViewController.swift
//  SwiftAppointments
//
//  Created by Venkata Vadigepalli on 30/12/2018.
//  Copyright © 2018 vvrmobilesolutions. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBAction func loginClick(sender:UIButton)
    {
        self.loginManager?.login(username: usernameTextField.text, password: passwordTextField.text){resultModel in
            DispatchQueue.main.async {
                if(!resultModel.result){
                    let alertViewController = UIAlertController(title: "", message: resultModel.message, preferredStyle: .alert)
                    alertViewController.addAction(UIAlertAction(title: "OK", style:.cancel, handler: nil))
                    self.present(alertViewController, animated: true, completion: nil)
                    return
                }
                self.usernameTextField.text = ""
                self.passwordTextField.text = ""
                self.performSegue(withIdentifier: "presentHomeFromLogin", sender: nil)
            }            
        }
    }
    
    @IBAction func unwindToLoginViewController(segue:UIStoryboardSegue) { }    
    
    var loginManager: LoginManager?
    var utils: Utils?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.text = "vraghavan"
        passwordTextField.text = "Venkat123"
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let serverUrl = utils?.getServerUrl(),
                  !serverUrl.isEmpty else {
            let alertViewController = UIAlertController(title: "", message: "Server URL is not set.", preferredStyle: .alert)
            alertViewController.addAction(UIAlertAction(title: "OK", style:.cancel, handler: nil))
            self.present(alertViewController, animated: true, completion: nil)
            return
        }
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
