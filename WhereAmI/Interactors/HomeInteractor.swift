//
//  HomeInteractor.swift
//  WhereAmI
//
//  Created by Aldo Corona on 29/05/20.
//  Copyright © 2020 IMOX. All rights reserved.
//

import Foundation

class HomeInteractor {
    func getTracked(token: String, callback: @escaping ([TrackedModel]?) -> Void) {
        let url = URL(string: "https://imponyx.herokuapp.com/tracked/getMyTracked")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
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
                        let value = try JSONDecoder().decode([TrackedModel].self, from: data)
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
