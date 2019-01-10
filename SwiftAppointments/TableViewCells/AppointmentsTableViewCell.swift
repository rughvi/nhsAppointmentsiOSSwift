//
//  AppointmentsTableViewCell.swift
//  SwiftAppointments
//
//  Created by Venkata Vadigepalli on 02/01/2019.
//  Copyright © 2019 vvrmobilesolutions. All rights reserved.
//

import UIKit

protocol AppointmentButtonsDelegate {
    func viewTapped (at indexPath: IndexPath)
    func printTapped (at indexPath: IndexPath)
}

class AppointmentsTableViewCell: UITableViewCell {

    var delegate: AppointmentButtonsDelegate!
    var indexPath: IndexPath!
    @IBOutlet weak var hospitalDetailsLabel: UILabel!
    @IBOutlet weak var appointmentDetailsLabel: UILabel!
    
    @IBAction func printClick(_ sender: Any) {
        self.delegate.viewTapped(at: indexPath)
    }
    
    @IBAction func saveClick(_ sender: Any) {
        self.delegate.printTapped(at: indexPath)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(hospitalAppointmentModel: HospitalAppointmentModel){
        hospitalDetailsLabel.text = "\(hospitalAppointmentModel.hospitalName) ( \(hospitalAppointmentModel.hospitalId) )"
        appointmentDetailsLabel.text = "\(hospitalAppointmentModel.dateOfAppointment) \(hospitalAppointmentModel.dayOfAppointment) \(hospitalAppointmentModel.timeOfAppointment)"
    }

}
