//
//  DBConnection.swift
//  WhereAmI
//
//  Created by Aldo Corona on 30/04/20.
//  Copyright © 2020 IMOX. All rights reserved.
//

import Foundation
import SQLite3

class DBConnection
{
    var db: OpaquePointer?
    var dbPath: String = "WhereAmISQLite.sqlite"
    
    init() {
        db = setConnection()
    }
    
    func setConnection() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
    func getConnection() -> OpaquePointer? {
        return db
    }
    
}
