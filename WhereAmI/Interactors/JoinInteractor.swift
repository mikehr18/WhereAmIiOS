//
//  JoinInteractor.swift
//  WhereAmI
//
//  Created by Aldo Corona on 03/05/20.
//  Copyright © 2020 IMOX. All rights reserved.
//

import Foundation

class JoinInteractor {
    func tryToJoin(name: String, cellphone: String, email: String, password: String, callback: @escaping (SignTokenModel) -> Void) {
        let url = URL(string: "https://imponyx.herokuapp.com/public/addUser")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postString = "email="+email+"&fullName="+name+"&password="+password+"&cellphone="+cellphone
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
                        let value = try JSONDecoder().decode(SignTokenModel.self, from: data)
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
