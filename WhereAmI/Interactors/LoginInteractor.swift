//
//  LoginInteractor.swift
//  WhereAmI
//
//  Created by Aldo Corona on 01/05/20.
//  Copyright © 2020 IMOX. All rights reserved.
//

import Foundation

class LoginInteractor {
    func loginRequest(username: String, password: String, callback: @escaping (LoginTokenModel?) -> Void) {
        let url = URL(string: "https://imponyx.herokuapp.com/public/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postString = "email="+username+"&password="+password
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
                if let response = response as? HTTPURLResponse {
                    print("status code: \(response.statusCode)")
                }
                if let data = data {
                    do {
                        let value = try JSONDecoder().decode(LoginTokenModel.self, from: data)
                        callback(value)
                    } catch {
                        print("Error during JSON serialization: \(error.localizedDescription)")
                    }
                }
            }
        }
        task.resume()
    }
}
 
