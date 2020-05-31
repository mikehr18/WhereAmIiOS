//
//  LoginPresenter.swift
//  WhereAmI
//
//  Created by Aldo Corona on 01/05/20.
//  Copyright © 2020 IMOX. All rights reserved.
//

import Foundation
import SQLite3

class LoginPresenter {
    private var loginInteractor: LoginInteractor?
    private var loginViewDelegate: LoginViewDelegate?
    private var validation: Validation?
    
    var connection: DBConnection?
    var db: OpaquePointer?
    	
    init() {
        loginInteractor = LoginInteractor()
        validation = Validation()
    }
    
    func setViewDelegate(loginView: LoginViewDelegate?) {
        self.loginViewDelegate = loginView
    }
    
    func tryLogin(email: (String), password: (String)) -> Void {
        if validation?.checkEmail(email: email) == true {
            loginInteractor?.loginRequest(username: email, password: password) { loginToken in
                if let loginToken = loginToken {
                    print(loginToken.success)
                    if loginToken.success == true {
                        if self.saveToken(token: loginToken.token, name: loginToken.name) == true {
                            self.loginViewDelegate?.successFunc(token: loginToken.token)
                        } else {
                            self.loginViewDelegate?.notLoggedIn(message: "Intente de nuevo más tarde")
                        }
                    } else {
                        self.loginViewDelegate?.notLoggedIn(message: "Usuario o contraseña incorrectos")
                    }
                }
            }
        } else {
            self.loginViewDelegate?.notLoggedIn(message: "Inserte un email válido")
        }
    }
    
    func saveToken(token: String, name: String) -> Bool{
        print(token)
        var succ: Bool = false
        connection = DBConnection()
        db = connection?.getConnection()
        let insertStatement = "INSERT INTO whereamiacount(token, name) VALUES (?, ?);"
        var insert: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatement, -1, &insert, nil) == SQLITE_OK {
            sqlite3_bind_text(insert, 1, (token as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insert, 2, (name as NSString).utf8String, -1, nil)
            if sqlite3_step(insert) == SQLITE_DONE {
                print("TOKEN insertado")
                succ = true
            } else {
                print("No se logró insertar")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insert)
        return succ
    }
}
