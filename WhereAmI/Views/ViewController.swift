//
//  ViewController.swift
//  WhereAmI
//
//  Created by Aldo Corona on 21/04/20.
//  Copyright © 2020 IMOX. All rights reserved.
//

import UIKit
import SQLite3

class ViewController: UIViewController {
    var connection: DBConnection?
    var db: OpaquePointer?
    var acount: TokenWhrmiModel?
    
    let brgb: CGFloat = 20/255
    let wrgb: CGFloat = 243/255
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var joinBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: wrgb, green: wrgb, blue: wrgb, alpha: 1)
        loginBtn.backgroundColor = UIColor(red: brgb, green: brgb, blue: brgb, alpha: 1)
        joinBtn.backgroundColor = UIColor(red: brgb, green: brgb, blue: brgb, alpha: 1)
        loginBtn.setTitleColor(UIColor(red: wrgb, green: wrgb, blue: wrgb, alpha: 1), for: .normal)
        joinBtn.setTitleColor(UIColor(red: wrgb, green: wrgb, blue: wrgb, alpha: 1), for: .normal)
        connection = DBConnection()
        db = connection?.getConnection()
        createTable()
        checkToken()
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS whereamiacount(token TEXT PRIMARY KEY, name TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("person table created.")
            } else {
                print("person table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func checkToken() {
        let queryStatementString = "SELECT token FROM whereamiacount;"
        var queryStatement: OpaquePointer? = nil
        var token: String = ""
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                guard let column = sqlite3_column_text(queryStatement, 0) else {
                    print("SELECT vacio")
                    return
                }
                token = String(cString: column)
            }
            print("SELECT realizado con exito")
            if(token != "") {
                let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeViewController
                homeVC.token = token
                self.navigationController?.pushViewController(homeVC, animated: true)
            }
        } else {
            print("SELECT no pudo ser preparado")
        }
        sqlite3_finalize(queryStatement)
    }
    
    @IBAction func loginBtnPushed(_ sender: Any) {
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    

    @IBAction func joinBtnPushed(_ sender: Any) {
        let joinVC = self.storyboard?.instantiateViewController(withIdentifier: "JoinVC") as! JoinViewController
        self.navigationController?.pushViewController(joinVC, animated: true)
    }
}

