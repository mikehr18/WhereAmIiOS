//
//  LocationInteractor.swift
//  WhereAmI
//
//  Created by Aldo Corona on 29/05/20.
//  Copyright © 2020 IMOX. All rights reserved.
//

import Foundation

class LocationInteractor {
    func getLocation(idDevice: String, callback:@escaping (LocationModel?) -> Void ) {
        let url = URL(string: "https://imponyx.herokuapp.com/location/getLocation")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postString = "idDevice="+idDevice
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
                        let value = try JSONDecoder().decode(LocationModel.self, from: data)
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
