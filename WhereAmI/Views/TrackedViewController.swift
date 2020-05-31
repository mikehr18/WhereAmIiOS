//
//  TrackedViewController.swift
//  WhereAmI
//
//  Created by Aldo Corona on 18/05/20.
//  Copyright © 2020 IMOX. All rights reserved.
//

import Foundation
import UIKit

class TrackedViewController: ViewController, TrackedViewDelegate {
    @IBOutlet weak var nameInput: FloatingLabelInput!
    @IBOutlet weak var dateInput: FloatingLabelInput!
    @IBOutlet weak var illnessInput: FloatingLabelInput!
    @IBOutlet weak var deviceInput: FloatingLabelInput!
    @IBOutlet weak var addTrackedButton: UIButton!
    
    let datePicker = UIDatePicker()
    var token: String = ""
    var trackedPresenter: TrackedPresenter = TrackedPresenter()
    
    override func viewDidLoad() {
        showDatePicker()
        nameInput.removeFloatingLabel()
        dateInput.removeFloatingLabel()
        illnessInput.removeFloatingLabel()
        deviceInput.removeFloatingLabel()
        trackedPresenter.setViewDelegate(trackedView: self)
    }
    
    func showDatePicker() {
        datePicker.datePickerMode = .date
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(canceldatePicker));
        toolbar.setItems([doneButton, spaceButton, cancelButton], animated: false)
        dateInput.inputAccessoryView = toolbar
        dateInput.inputView = datePicker
    }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dateInput.text = formatter.string(from: datePicker.date)
        self.dateInput.endEditing(true)
    }
    
    @objc func canceldatePicker(){
        self.dateInput.endEditing(true)
    }
    
    @IBAction func addTrackedClicked(_ sender: Any) {
        DispatchQueue.main.async {
            self.addTrackedButton.setTitle("...", for: .normal)
            self.addTrackedButton.isEnabled = false
        }
        let name = nameInput.text ?? ""
        let date = dateInput.text ?? ""
        let illness = illnessInput.text ?? ""
        let idDevice = deviceInput.text ?? ""
        trackedPresenter.tryLogin(name: name, date: date, illness: illness, idDevice: idDevice, token: self.token)
    }
    
    func successFunc() {
        DispatchQueue.main.async {
            let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeViewController
            homeVC.token = self.token
            self.navigationController?.pushViewController(homeVC, animated: true)
        }
    }
    
    func notAdded(message: String) {
        DispatchQueue.main.async {
            self.addTrackedButton.setTitle("Añadir", for: .normal)
            self.addTrackedButton.isEnabled = true
            let dialogMessage = UIAlertController(title: "Error al añadir", message: message, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            dialogMessage.addAction(ok)
            self.present(dialogMessage, animated: true, completion: nil)
        }
    }
}

protocol TrackedViewDelegate: NSObjectProtocol {
    func successFunc()
    func notAdded(message: String)
}
