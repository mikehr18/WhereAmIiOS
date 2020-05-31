//
//  JoinViewController.swift
//  WhereAmI
//
//  Created by Aldo Corona on 21/04/20.
//  Copyright © 2020 IMOX. All rights reserved.
//

import Foundation
import UIKit

class JoinViewController: ViewController, JoinViewDelegate {
    
    @IBOutlet weak var nameInput: FloatingLabelInput!
    @IBOutlet weak var cellphoneInput: FloatingLabelInput!
    @IBOutlet weak var emailInput: FloatingLabelInput!
    @IBOutlet weak var passwordInput: FloatingLabelInput!
    @IBOutlet weak var passVerifINput: FloatingLabelInput!
    @IBOutlet weak var joinViewBtn: UIButton!
    
    private var joinPresenter = JoinPresenter()
    
    
    override func viewDidLoad() {
        self.nameInput.removeFloatingLabel()
        self.cellphoneInput.removeFloatingLabel()
        self.emailInput.removeFloatingLabel()
        self.passwordInput.removeFloatingLabel()
        self.passVerifINput.removeFloatingLabel()
        self.joinViewBtn.backgroundColor = UIColor(red: brgb, green: brgb, blue: brgb, alpha: 1)
        self.joinViewBtn.setTitleColor(UIColor(red: wrgb, green: wrgb, blue: wrgb, alpha: 1), for: .normal)
        joinPresenter.setDelegate(joinDelegate: self)
    }
    
    func hideKeyboardOnTapAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction func joinBtnClicked(_ sender: Any) {
        DispatchQueue.main.async {
            self.joinViewBtn.setTitle("Cargando...", for: .normal)
            self.joinViewBtn.isEnabled = false
        }
        let name = nameInput.text ?? ""
        let phone = cellphoneInput.text ?? ""
        let email = emailInput.text ?? ""
        let pass1 = passwordInput.text ?? ""
        let pass2 = passVerifINput.text ?? ""
        if pass1 == pass2 {
            self.joinPresenter.trySignIn(name: name, cellphone: phone, email: email, password: pass1)
        } else {
            self.notJoined(message: "Las contraseñas no coinciden")
        }
    }
    
    func success(token: String) {
        DispatchQueue.main.async {
            let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeViewController
            homeVC.token = token
            self.navigationController?.pushViewController(homeVC, animated: true)
        }
    }
    
    func notJoined(message: String) {
        DispatchQueue.main.async {
            self.joinViewBtn.setTitle("Unirse", for: .normal)
            self.joinViewBtn.isEnabled = true
            let dialogMessage = UIAlertController(title: "No pudimos unirte", message: message, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            dialogMessage.addAction(ok)
            self.present(dialogMessage, animated: true, completion: nil)
        }
    }
}

protocol JoinViewDelegate: NSObjectProtocol {
    func success(token: String)
    func notJoined(message: String)
}
