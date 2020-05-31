//
//  ConfigurationViewController.swift
//  WhereAmI
//
//  Created by Aldo Corona on 18/05/20.
//  Copyright © 2020 IMOX. All rights reserved.
//

import Foundation
import UIKit
import SQLite3

class ConfigurationViewController: ViewController {
    
    var token: String = ""
    
    @IBOutlet weak var myAcountBtn: UIButton!
    @IBOutlet weak var trackedConfBtn: UIButton!
    @IBOutlet weak var safeZoneBtn: UIButton!
    @IBOutlet weak var logoutBtn: UIButton!
    
    override func viewDidLoad() {
        myAcountBtn.backgroundColor = UIColor(red: brgb, green: brgb, blue: brgb, alpha: 1)
        trackedConfBtn.backgroundColor = UIColor(red: brgb, green: brgb, blue: brgb, alpha: 1)
        safeZoneBtn.backgroundColor = UIColor(red: brgb, green: brgb, blue: brgb, alpha: 1)
        logoutBtn.backgroundColor = UIColor(red: 247/255, green: 80/255, blue: 80/255, alpha: 1)
        myAcountBtn.setTitleColor(UIColor(red: wrgb, green: wrgb, blue: wrgb, alpha: 1), for: .normal)
        trackedConfBtn.setTitleColor(UIColor(red: wrgb, green: wrgb, blue: wrgb, alpha: 1), for: .normal)
        safeZoneBtn.setTitleColor(UIColor(red: wrgb, green: wrgb, blue: wrgb, alpha: 1), for: .normal)
        logoutBtn.setTitleColor(UIColor(red: wrgb, green: wrgb, blue: wrgb, alpha: 1), for: .normal)
        connection = DBConnection()
        db = connection?.getConnection()
    }
    
    @IBAction func logoutBtnClicker(_ sender: Any) {
        let deleteStatementString = "DELETE FROM whereamiacount;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Token deleted")
            } else {
                print("Could not delete")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
        let inVC = self.storyboard?.instantiateViewController(withIdentifier: "inVC") as! ViewController
        self.navigationController?.pushViewController(inVC, animated: true)
    }
    @IBAction func myaccountBtnClicked(_ sender: Any) {
    }
    
    @IBAction func addTrackClicked(_ sender: Any) {
        let trackedVC = self.storyboard?.instantiateViewController(withIdentifier: "trackedVC") as! TrackedViewController
        trackedVC.token = self.token
        self.navigationController?.pushViewController(trackedVC, animated: true)
    }
    
    @IBAction func safeZoneClicked(_ sender: Any) {
    }
}
