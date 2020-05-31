//
//  TrackedInteractor.swift
//  WhereAmI
//
//  Created by Aldo Corona on 28/05/20.
//  Copyright © 2020 IMOX. All rights reserved.
//

import Foundation

class TrackedInteractor {
    func addTrackedRequest(name: String, date: String, illness: String, idDevice: String, token: String, callback: @escaping (SuccessModel?) -> Void) {
        let url = URL(string: "https://imponyx.herokuapp.com/tracked/newTracked")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postString = "name="+name+"&date="+date+"&illness="+illness+"&idDevice="+idDevice
        request.httpBody = postString.data(using: .utf8)
        request.addValue(token, forHTTPHeaderField: "token")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
                if let response = response as? HTTPURLResponse {
                    print("status code: \(response.statusCode)")
                }
                if let data = data {
                    do {
                        print(data)
                        let value = try JSONDecoder().decode(SuccessModel.self, from: data)
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
