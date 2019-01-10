//
//  DocumentViewController.swift
//  SwiftAppointments
//
//  Created by Venkata Vadigepalli on 10/01/2019.
//  Copyright © 2019 vvrmobilesolutions. All rights reserved.
//

import UIKit
import PDFKit

class DocumentViewController: UIViewController {

    @IBOutlet weak var pdfView: PDFView!
    
    //private var pdfView : PDFView?
    var pdfFileLocalUrl: URL?
    var printerController: PrinterController?
    
    @IBAction func backButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "unwindToHomeViewController", sender: nil)
    }
    
    @IBAction func printClick(_ sender: Any) {
        printerController?.print(pdfFileLocalUrl: pdfFileLocalUrl){success, error in
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        pdfView.autoScales = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let fileUrl = pdfFileLocalUrl {
            if let pdfDocument = PDFDocument(url: fileUrl){
                pdfView?.document = pdfDocument
            }
        }
        else {
            let alertViewController = UIAlertController(title: "", message: "No document found", preferredStyle: .alert)
            alertViewController.addAction(UIAlertAction(title: "OK", style:.cancel, handler: nil))
            self.present(alertViewController, animated: true, completion: nil)
        }
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
