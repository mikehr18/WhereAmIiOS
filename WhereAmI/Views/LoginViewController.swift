//
//  LoginViewController.swift
//  WhereAmI
//
//  Created by Aldo Corona on 21/04/20.
//  Copyright © 2020 IMOX. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: ViewController, LoginViewDelegate {
    private let loginPresenter = LoginPresenter()
    
    @IBOutlet weak var usernameInput: FloatingLabelInput!
    @IBOutlet weak var passwordInput: FloatingLabelInput!
    @IBOutlet weak var loginViewBtn: UIButton!
    
    override func viewDidLoad() {
        loginViewBtn.backgroundColor = UIColor(red: brgb, green: brgb, blue: brgb, alpha: 1)
        loginViewBtn.setTitleColor(UIColor(red: wrgb, green: wrgb, blue: wrgb, alpha: 1), for: .normal)
        self.hideKeyboardOnTapAround()
        self.usernameInput.removeFloatingLabel()
        self.passwordInput.removeFloatingLabel()
        loginPresenter.setViewDelegate(loginView: self)
    }
    
    func hideKeyboardOnTapAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    func successFunc(token: String) {
        DispatchQueue.main.async {
            let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeViewController
            homeVC.token = token
            self.navigationController?.pushViewController(homeVC, animated: true)
        }
    }
    
    func notLoggedIn(message: String) {
        DispatchQueue.main.async {
            self.loginViewBtn.setTitle("Iniciar Sesión", for: .normal)
            let dialogMessage = UIAlertController(title: "No se pudo iniciar sesión", message: message, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            dialogMessage.addAction(ok)
            self.present(dialogMessage, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func loginBtnClicked(_ sender: Any) {
        DispatchQueue.main.async {
            self.loginViewBtn.setTitle("Cargando...", for: .normal)
        }
        let username: String = usernameInput.text ?? ""
        let password: String = passwordInput.text ?? ""
        loginPresenter.tryLogin(email: username, password: password)
    }
}

protocol LoginViewDelegate: NSObjectProtocol {
    func successFunc(token: String)
    func notLoggedIn(message: String)
}
