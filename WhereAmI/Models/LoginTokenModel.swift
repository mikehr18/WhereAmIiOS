//
//  LoginTokenModel.swift
//  WhereAmI
//
//  Created by Aldo Corona on 01/05/20.
//  Copyright © 2020 IMOX. All rights reserved.
//

import Foundation

struct LoginTokenModel: Codable {
    let success: Bool
    let token: String
    let name: String
}
