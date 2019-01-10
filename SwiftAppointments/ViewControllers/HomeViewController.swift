//
//  HomeViewController.swift
//  SwiftAppointments
//
//  Created by Venkata Vadigepalli on 30/12/2018.
//  Copyright © 2018 vvrmobilesolutions. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITabBarDelegate, UITableViewDelegate, UITableViewDataSource, AppointmentButtonsDelegate {
    
    @IBOutlet weak var appointmentsTableView: UITableView!
    @IBAction func unwindToHomeViewController(segue:UIStoryboardSegue) { }
    @IBOutlet weak var tabbar: UITabBar!
    
    var appSession: AppSession?
    var hospitalsManager : HospitalsManager?
    var fileDownloadManger: FileDownloadManager?
    private var hospitalAppointmentModels: [HospitalAppointmentModel]?
    private var pdfFileLocalUrl: URL?
    var printerController: PrinterController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabbar.delegate = self
        appointmentsTableView.tableFooterView = UIView()
        appointmentsTableView.tableFooterView?.isHidden = true
        
        hospitalsManager?.getUserHospitals(userId: (appSession?.userId!)!){ resultModel, hospitalAppointmentModels in
            if(!resultModel.result) {
                let alertViewController = UIAlertController(title: "", message: resultModel.message, preferredStyle: .alert)
                alertViewController.addAction(UIAlertAction(title: "OK", style:.cancel, handler: nil))
                self.present(alertViewController, animated: true, completion: nil)
                return
            }
            
            guard let hospitalAppointmentModels = hospitalAppointmentModels else {
                return
            }
            
            if(hospitalAppointmentModels.count == 0){
                return
            }
            
            self.hospitalAppointmentModels = hospitalAppointmentModels
            DispatchQueue.main.async { [weak self] in
                self?.appointmentsTableView.reloadData()
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let hospitalAppointmentModels = self.hospitalAppointmentModels else {
            return 0
        }
        
        return hospitalAppointmentModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var appointmentsTableViewCell = appointmentsTableView.dequeueReusableCell(withIdentifier: "AppointmentsTableCell", for: indexPath) as! AppointmentsTableViewCell
        
        let hospitalAppointmentModel = self.hospitalAppointmentModels![indexPath.row]
        appointmentsTableViewCell.updateCell(hospitalAppointmentModel: hospitalAppointmentModel)
        appointmentsTableViewCell.delegate = self
        appointmentsTableViewCell.indexPath = indexPath
        return appointmentsTableViewCell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            //settings
            performSegue(withIdentifier: "presentSettingsFromHome", sender: self)
            break
        case 1:
            performSegue(withIdentifier: "presentAddHospitalFromHome", sender: self)
            break
        case 2:
            //logout
            appSession?.clearSession()
            performSegue(withIdentifier: "unwindToLoginViewController", sender: self)
            break
        default:
            break
        }
        tabBar.selectedItem = nil
    }
    
    func viewTapped(at indexPath: IndexPath) {
        
        //first loacal file URL
        let fileUrlString = "http://www.orimi.com/pdf-test.pdf"
        fileDownloadManger?.downloadFile(fileUrlString: fileUrlString){ resultModel, destinationFileUrl in
            if(!resultModel.result){
                let alertViewController = UIAlertController(title: "", message: resultModel.message, preferredStyle: .alert)
                alertViewController.addAction(UIAlertAction(title: "OK", style:.cancel, handler: nil))
                self.present(alertViewController, animated: true, completion: nil)
                return
            }
            
            guard let fileUrl = destinationFileUrl else {
                let alertViewController = UIAlertController(title: "", message: "Local file url is not present", preferredStyle: .alert)
                alertViewController.addAction(UIAlertAction(title: "OK", style:.cancel, handler: nil))
                self.present(alertViewController, animated: true, completion: nil)
                return
            }
            
            self.pdfFileLocalUrl = fileUrl
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "presentDocumentFromHome", sender: self)
            }
        }
    }
    
    func printTapped(at indexPath: IndexPath) {
        let fileUrlString = "http://www.orimi.com/pdf-test.pdf"
        fileDownloadManger?.downloadFile(fileUrlString: fileUrlString){ resultModel, destinationFileUrl in
            if(!resultModel.result){
                let alertViewController = UIAlertController(title: "", message: resultModel.message, preferredStyle: .alert)
                alertViewController.addAction(UIAlertAction(title: "OK", style:.cancel, handler: nil))
                self.present(alertViewController, animated: true, completion: nil)
                return
            }
            
            self.printClick(fileUrl: destinationFileUrl)
        }
    }
    
    func printClick(fileUrl: URL?){
        printerController?.print(pdfFileLocalUrl: fileUrl){success, error in
            if(success){
                let alertViewController = UIAlertController(title: "", message: "Document printed successfully", preferredStyle: .alert)
                alertViewController.addAction(UIAlertAction(title: "OK", style:.cancel, handler: nil))
                self.present(alertViewController, animated: true, completion: nil)
            } else {
                if let error = error{
                    let alertViewController = UIAlertController(title: "", message: error.localizedDescription, preferredStyle: .alert)
                    alertViewController.addAction(UIAlertAction(title: "OK", style:.cancel, handler: nil))
                    self.present(alertViewController, animated: true, completion: nil)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "presentDocumentFromHome"){
            let documentViewController = segue.destination as! DocumentViewController
            documentViewController.pdfFileLocalUrl = self.pdfFileLocalUrl
        }
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
