//
//  Validation.swift
//  WhereAmI
//
//  Created by Aldo Corona on 08/05/20.
//  Copyright © 2020 IMOX. All rights reserved.
//

import Foundation

class Validation {
    func checkEmail(email: String) -> Bool {
        let emailPattern = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        do {
            let regEx = try NSRegularExpression(pattern: emailPattern, options: [])
            let nsString = email as NSString
            let matches = regEx.matches(in: email, options: [], range: NSMakeRange(0, nsString.length))
            
            if matches.count > 0 {
                return true
            } else {
                return false
            }
        } catch let error as NSError {
            print(error)
            return false
        }
    }
    
    func checkName(name: String) -> Bool {
        let namePattern = "^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$"
        do {
            let regEx = try NSRegularExpression(pattern: namePattern, options: [])
            let nsString = name as NSString
            let matches = regEx.matches(in: name, options: [], range: NSMakeRange(0, nsString.length))
            
            if matches.count > 0 {
                return true
            } else {
                return false
            }
        } catch let error as NSError {
            print(error)
            return false
        }
    }
    
    func checkPhone(phone: String) -> Bool {
        let phonePattern = "^[0-9]{10}$"
        do {
            let regEx = try NSRegularExpression(pattern: phonePattern, options: [])
            let nsString = phone as NSString
            let matches = regEx.matches(in: phone, options: [], range: NSMakeRange(0, nsString.length))
            
            if matches.count > 0 {
                return true
            } else {
                return false
            }
        } catch let error as NSError {
            print(error)
            return false
        }
    }
}
