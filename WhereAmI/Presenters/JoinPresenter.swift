//
//  JoinPresenter.swift
//  WhereAmI
//
//  Created by Aldo Corona on 03/05/20.
//  Copyright © 2020 IMOX. All rights reserved.
//

import Foundation
import SQLite3

class JoinPresenter {
    private var joinInteractor: JoinInteractor?
    private var joinDelegate: JoinViewDelegate?
    private var validation = Validation()
    
    var connection: DBConnection?
    var db: OpaquePointer?
    
    init() {
        joinInteractor = JoinInteractor()
    }
    
    func setDelegate(joinDelegate: JoinViewDelegate){
        self.joinDelegate = joinDelegate
    }
    
    func trySignIn(name: String, cellphone: String, email: String, password: String ) -> Void{
        if validation.checkEmail(email: email) == true {
            if validation.checkName(name: name) == true {
                if validation.checkPhone(phone: cellphone) {
                    joinInteractor?.tryToJoin(name: name, cellphone: cellphone, email: email, password: password) { joinModel in
                        switch joinModel.status {
                        case "exists":
                            self.joinDelegate?.notJoined(message: "Correo ligado a una cuenta existente")
                        case "failed":
                            self.joinDelegate?.notJoined(message: "Intente de nuevo más tarde")
                        default:
                            if self.saveToken(token: joinModel.token, name: joinModel.name) == true {
                                self.joinDelegate?.success(token: joinModel.token)
                            } else {
                                self.joinDelegate?.notJoined(message: "Intente de nuevo más tarde")
                            }
                        }
                    }
                } else {
                    self.joinDelegate?.notJoined(message: "Inserte un número de teléfono de 10 dígitos")
                }
            } else {
                self.joinDelegate?.notJoined(message: "Inserte un nombre válido")
            }
        } else {
            self.joinDelegate?.notJoined(message: "Inserte un email válido")
        }
    }
    
    func saveToken(token: String, name: String) -> Bool{
        var succ: Bool = false
        connection = DBConnection()
        db = connection?.getConnection()
        let insertStatement = "INSERT INTO whereamiacount(token, name) VALUES (?, ?);"
        var insert: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatement, -1, &insert, nil) == SQLITE_OK {
            sqlite3_bind_text(insert, 1, (token as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insert, 1, (name as NSString).utf8String, -1, nil)
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
